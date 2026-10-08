--!strict


local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local WeatherService = {}
WeatherService.__index = WeatherService

function WeatherService.new()
    return setmetatable({
        weather = "Clear",
        transition = 0,
    }, WeatherService)
end

function WeatherService:set(weather: string)
    if weather ~= "Clear" and weather ~= "Dust" and weather ~= "Night" and weather ~= "Sunset" then
        return false
    end

    self.weather = weather
    local goal = {}

    if weather == "Clear" then
        goal.Brightness = 2
        goal.ClockTime = 14
        goal.ExposureCompensation = 0
    elseif weather == "Dust" then
        goal.Brightness = 1.2
        goal.ClockTime = 16
        goal.ExposureCompensation = -0.2
    elseif weather == "Night" then
        goal.Brightness = 0.8
        goal.ClockTime = 0
        goal.ExposureCompensation = -0.4
    elseif weather == "Sunset" then
        goal.Brightness = 1.4
        goal.ClockTime = 18.2
        goal.ExposureCompensation = -0.1
    end

    TweenService:Create(Lighting, TweenInfo.new(8), goal):Play()
    return true
end

function WeatherService:get(): string
    return self.weather
end

return WeatherService
