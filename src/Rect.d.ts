import  Point2D from './Point';
import Segment from './Segment';
interface GRect {
    getMaxPoint(): Point2D;
    getMinPoint(): Point2D;
    getSides(): [Segment, Segment, Segment, Segment];
    getPoints(): [Point2D, Point2D, Point2D, Point2D];
    getSize(): Point2D;
    getArea(): number;
    getPerimeter(): number;
    getRotation(): number;
    getAxisAlignedRect(): GRect;
    getBoundingBox(): GRect;
    isPointInside(p: Point2D): boolean;
    getCenter(): Point2D;
    intersects(segment: Segment): boolean;
    intersectsRect(rect: GRect): boolean;
    getIntersection(segment: Segment): Point2D | Segment | undefined;
}

interface GRectConstructor {
    createRectFromPoints(p1: Point2D, p2: Point2D, p3: Point2D, p4: Point2D): GRect;
    createRectFromPart(part: { Size: Vector3; CFrame: CFrame }): GRect;
}

declare const GRect: GRectConstructor;
export = GRect;