--!strict


local RunService = game:GetService("RunService")

local Constants = require(game.ReplicatedStorage.Shared.Constants)
local EngineModel = require(game.ReplicatedStorage.Shared.EngineModel)
local Transmission = require(game.ReplicatedStorage.Shared.Transmission)
local TireModel = require(game.ReplicatedStorage.Shared.TireModel)
local SuspensionModel = require(game.ReplicatedStorage.Shared.SuspensionModel)
local AeroModel = require(game.ReplicatedStorage.Shared.AeroModel)
local DriveMode = require(game.ReplicatedStorage.Shared.DriveMode)
local Units = require(game.ReplicatedStorage.Shared.Units)

local VehiclePhysicsService = {}
VehiclePhysicsService.__index = VehiclePhysicsService

local WHEELS = {"FL", "FR", "RL", "RR"}

function VehiclePhysicsService.new(registry)
    return setmetatable({
        registry = registry,
        active = {},
    }, VehiclePhysicsService)
end

function VehiclePhysicsService:add(state)
    local model = state.model
    local chassis = model.PrimaryPart
    assert(chassis)

    local engine = EngineModel.new(state.profile)
    local transmission = Transmission.new(state.profile)

    local wheelAttachments = {}
    local forces = {}

    local attachments = model:FindFirstChild("Attachments")
    for _, name in ipairs(WHEELS) do
        local a = attachments and attachments:FindFirstChild(name)
        if a and a:IsA("Attachment") then
            wheelAttachments[name] = a
            local vf = Instance.new("VectorForce")
            vf.Name = "Force_" .. name
            vf.Attachment0 = a
            vf.RelativeTo = Enum.ActuatorRelativeTo.World
            vf.ApplyAtCenterOfMass = false
            vf.Force = Vector3.zero
            vf.Parent = a
            forces[name] = vf
        end
    end

    state.physics = {
        engine = engine,
        transmission = transmission,
        wheelAttachments = wheelAttachments,
        forces = forces,
    }
    self.active[state] = true
end

function VehiclePhysicsService:remove(state)
    self.active[state] = nil
end

function VehiclePhysicsService:step(state, dt: number)
    local model = state.model
    local chassis = model.PrimaryPart
    if not chassis then return end

    local p = state.profile
    local tuning = state.tuning
    local input = state.input
    local physics = state.physics
    if not physics then return end

    local velocity = chassis.AssemblyLinearVelocity
    local localVelocity = chassis.CFrame:VectorToObjectSpace(velocity)
    local speed = velocity.Magnitude

    local estimatedWheelRpm = math.abs(localVelocity.Z) / math.max(p.tires.radiusM, 0.05) * 60 / (2 * math.pi) * 0.65
    local targetRpm = math.max(p.engine.idleRpm, estimatedWheelRpm * math.max(physics.transmission:ratio(), 0.1))
    local engineTorque = physics.engine:step(input.throttle, targetRpm, dt)
    local driveRatio = physics.transmission:step(dt, physics.engine.rpm, input.throttle, speed)
    local wheelTorque = engineTorque * driveRatio

    local frontShare, rearShare = DriveMode.distribution(input.driveMode, p.differential.frontBias)
    local forward = chassis.CFrame.LookVector
    local right = chassis.CFrame.RightVector

    local drag, downforce = AeroModel.calculate(
        Units.studsToMeters(speed),
        Constants.AirDensitySeaLevel,
        p.aero.cd,
        p.aero.frontalArea,
        p.aero.downforceCoeff,
        tuning.downforceScale
    )

    local dragForce = -forward * Units.metersToStuds(drag)
    local downForce = Vector3.new(0, -Units.metersToStuds(downforce), 0)
    chassis:ApplyImpulse((dragForce + downForce) * dt * chassis.AssemblyMass)

    local totalLongitudinal = 0
    local totalLateral = 0
    local wheelRadius = p.tires.radiusM
    local wheelForceScale = Units.metersToStuds(1)

    for _, name in ipairs(WHEELS) do
        local attachment = physics.wheelAttachments[name]
        local force = physics.forces[name]
        if attachment and force then
            local rayOrigin = attachment.WorldPosition
            local rayDirection = Vector3.new(0, -math.max(p.suspension.travel, 0.1) * wheelForceScale, 0)
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Exclude
            params.FilterDescendantsInstances = {model}

            local hit = workspace:Raycast(rayOrigin, rayDirection, params)
            local grounded = hit ~= nil
            local normalLoad = chassis.AssemblyMass * Constants.Gravity / 4

            if grounded then
                local pointVelocity = chassis:GetVelocityAtPosition(rayOrigin)
                local localPointVelocity = chassis.CFrame:VectorToObjectSpace(pointVelocity)
                local steer = (name == "FL" or name == "FR") and input.steer or 0
                local steerRad = math.rad(p.steering.maxAngleDeg) * steer

                local slipAngle = TireModel.slipAngle(localPointVelocity, steerRad)
                local forwardSpeed = -localPointVelocity.Z
                local driveFraction = (name == "FL" or name == "FR") and frontShare or rearShare
                local drivenTorque = wheelTorque * driveFraction / 2
                local targetWheelForce = drivenTorque / math.max(wheelRadius, 0.1)
                local slipRatio = targetWheelForce / math.max(normalLoad * p.tires.mu, 1)

                local longitudinal, lateral = TireModel.calculate(
                    normalLoad,
                    slipRatio,
                    slipAngle,
                    p.tires.mu * tuning.tireGrip
                )

                if input.brake > 0 then
                    longitudinal -= math.sign(forwardSpeed) * normalLoad * 1.55 * input.brake
                end

                if input.handbrake and (name == "RL" or name == "RR") then
                    longitudinal *= 0.18
                    lateral *= 0.55
                end

                local wheelForward = chassis.CFrame.LookVector
                local wheelRight = chassis.CFrame.RightVector
                local f = wheelForward * longitudinal + wheelRight * (-lateral)
                force.Force = f * wheelForceScale

                totalLongitudinal += longitudinal
                totalLateral += lateral
            else
                force.Force = Vector3.zero
            end
        end
    end

    state.telemetry = {
        speedMps = Units.studsToMeters(speed),
        speedKph = Units.mpsToKph(Units.studsToMeters(speed)),
        rpm = physics.engine.rpm,
        gear = physics.transmission.gear,
        throttle = input.throttle,
        brake = input.brake,
        steer = input.steer,
        longitudinalForce = totalLongitudinal,
        lateralForce = totalLateral,
        yawRate = chassis.AssemblyAngularVelocity.Y,
    }
end

function VehiclePhysicsService:start()
    self.connection = RunService.Heartbeat:Connect(function(dt)
        local fixed = math.min(dt, 1 / 30)
        for state in pairs(self.active) do
            self:step(state, fixed)
        end
    end)
end

function VehiclePhysicsService:stop()
    if self.connection then
        self.connection:Disconnect()
        self.connection = nil
    end
end

return VehiclePhysicsService
