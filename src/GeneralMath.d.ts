import IPoint2D from "./Point";

interface IGeneralMath {
    getX_2MB: (m1: number, b1: number, m2: number, b2: number) => number;
    getY_XMB: (x: number, m: number, b: number) => number;
    getX_YMB: (y: number, m: number, b: number) => number;
    gentroid: (points: IPoint2D[]) => IPoint2D;
    getAngle_2Points: (p1: IPoint2D, p2: IPoint2D) => number;
    getDistance_2Points: (p1: IPoint2D, p2: IPoint2D) => number;
    rotatePoint: (x: number, y: number, angle: number) => [number, number];
}

declare const GeneralMath: IGeneralMath;
export = GeneralMath;