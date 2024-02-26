interface Point2D {
    equals(point: Point2D): boolean;
    getX(): number;
    getY(): number;
    toVector2(): Vector2;
    add(point: Point2D): Point2D;
    subtract(point: Point2D): Point2D;
    dividedBy(value: number): Point2D;
}

interface IPoint2DConstructor {
    new(x: number, y: number): Point2D;
}

declare const Point2D: IPoint2DConstructor;
export = Point2D;