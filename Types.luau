--!strict


export type DriveMode = "RWD" | "FWD" | "AWD"
export type VehicleClass = "Hypercar" | "Supercar" | "SUV" | "Tuner"
export type RaceType = "Drag" | "Highway" | "Drift"

export type InputState = {
    throttle: number,
    brake: number,
    steer: number,
    handbrake: boolean,
    clutch: number,
    requestedGear: number?,
    driveMode: DriveMode,
}

export type WheelState = {
    grounded: boolean,
    compression: number,
    normalLoad: number,
    slipRatio: number,
    slipAngle: number,
    longitudinalForce: number,
    lateralForce: number,
}

export type VehicleTelemetry = {
    speedMps: number,
    speedKph: number,
    rpm: number,
    gear: number,
    throttle: number,
    brake: number,
    steer: number,
    longitudinalG: number,
    lateralG: number,
    yawRate: number,
    driftAngle: number,
    wheelSpin: number,
}

export type Tuning = {
    finalDrive: number,
    gearRatios: {number},
    boostPsi: number,
    boostResponse: number,
    springScale: number,
    damperScale: number,
    camberFront: number,
    camberRear: number,
    toeFront: number,
    toeRear: number,
    brakeBias: number,
    tireGrip: number,
    tirePressure: number,
    rideHeight: number,
    downforceScale: number,
}

export type VehicleProfile = {
    id: string,
    displayName: string,
    class: VehicleClass,
    massKg: number,
    wheelbaseM: number,
    trackFrontM: number,
    trackRearM: number,
    cgHeightM: number,
    engine: any,
    transmission: any,
    differential: any,
    suspension: any,
    tires: any,
    aero: any,
    steering: any,
    allowedModes: {DriveMode},
    stockTuning: Tuning,
}
