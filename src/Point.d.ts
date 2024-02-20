interface Point2D {
    equals(point: Point2D): boolean;
    getX(): number;
    getY(): number;
}

interface IPoint2DConstructor {
    new(x: number, y: number): Point2D;
}

declare const Point2D: IPoint2DConstructor;
export = Point2D;