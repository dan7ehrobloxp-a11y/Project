--!strict


export type ColorSpec = {
    primary: Color3,
    secondary: Color3,
    accent: Color3,
    pearl: number,
    metallic: number,
}

export type WheelSpec = {
    wheelId: string,
    diameter: number,
    width: number,
    offset: number,
    tireCompound: string,
}

export type BodyKitSpec = {
    frontBumper: string,
    rearBumper: string,
    sideSkirt: string,
    hood: string,
    spoiler: string,
    diffuser: string,
}

export type Customization = {
    paint: ColorSpec,
    wheels: WheelSpec,
    bodyKit: BodyKitSpec,
    frontCamber: number,
    rearCamber: number,
    rideHeight: number,
    ghostDriver: boolean,
}
