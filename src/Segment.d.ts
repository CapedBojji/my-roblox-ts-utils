import Point2D from "./Point"

interface Segment {
    getPoints(): [Point2D, Point2D];
    getSlope(): number | undefined;
    getLength(): number;
    isVertical(): boolean;
    isHorizontal(): boolean;
    isParallelTo(segment: Segment): boolean;
    isPerpendicularTo(segment: Segment): boolean;
    xIntercept(): number | undefined;
    yIntercept(): number | undefined;
    equals(segment: Segment): boolean;
    isCollinearWith(segment: Segment): boolean;
    containsPoint(point: Point2D): boolean;
    intersects(segment: Segment): boolean;
    getIntersection(segment: Segment): Point2D | undefined | Segment;
}

interface SegmentConstructor {
    new (p1: Point2D, p2: Point2D): Segment;
}

declare const Segment: SegmentConstructor;
export = Segment;