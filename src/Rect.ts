import Point2D from "./Point";
import Segment from "./Segment";
import GeneralMath from "GeneralMath";

class GRect{
	private constructor(
		private readonly p1: Point2D,
		private readonly p2: Point2D,
		private readonly p3: Point2D,
		private readonly p4: Point2D,
	) {}

	static createRectFromPoints(p1: Point2D, p2: Point2D, p3: Point2D, p4: Point2D): GRect {
		const centroidPoint = GeneralMath.centroid([p1, p2, p3, p4]);
		const points = [p1, p2, p3, p4];
		points.sort((a, b) => {
			return GeneralMath.getAngle_2Points(a, centroidPoint) > GeneralMath.getAngle_2Points(b, centroidPoint);
		});
		return new GRect(points[0], points[1], points[2], points[3]);
	}

	static createRectFromPart(part: { Size: Vector3; CFrame: CFrame }): GRect {
		const size = part.Size;
		const cframe = part.CFrame;
		const p1 = cframe.mul(new CFrame(-size.X / 2, 0, -size.Z / 2));
		const p2 = cframe.mul(new CFrame(size.X / 2, 0, -size.Z / 2));
		const p3 = cframe.mul(new CFrame(size.X / 2, 0, size.Z / 2));
		const p4 = cframe.mul(new CFrame(-size.X / 2, 0, size.Z / 2));
		return GRect.createRectFromPoints(
			new Point2D(p1.Position.X, p1.Position.Z),
			new Point2D(p2.Position.X, p2.Position.Z),
			new Point2D(p3.Position.X, p3.Position.Z),
			new Point2D(p4.Position.X, p4.Position.Z),
		);
	}

	getMaxPoint(): Point2D {
		const points = this.getPoints();
		const x = points.map((p) => p.getX());
		const y = points.map((p) => p.getY());
		const maxX = math.max(...x);
		const maxY = math.max(...y);
		return new Point2D(maxX, maxY);
	}

	getMinPoint(): Point2D {
		const points = this.getPoints();
		const x = points.map((p) => p.getX());
		const y = points.map((p) => p.getY());
		const minX = math.min(...x);
		const minY = math.min(...y);
		return new Point2D(minX, minY);
	}

	getSides(): [Segment, Segment, Segment, Segment] {
		return [
			new Segment(this.p1, this.p2),
			new Segment(this.p2, this.p3),
			new Segment(this.p3, this.p4),
			new Segment(this.p4, this.p1),
		];
	}

	getPoints(): [Point2D, Point2D, Point2D, Point2D] {
		return [this.p1, this.p2, this.p3, this.p4];
	}

	getSize(): Point2D {
		const length = GeneralMath.getDistance_2Points(this.p1, this.p2);
		const width = GeneralMath.getDistance_2Points(this.p2, this.p3);
		return new Point2D(length, width);
	}

	getArea(): number {
		const size = this.getSize();
		return size.getX() * size.getY();
	}

	getPerimeter(): number {
		const size = this.getSize();
		return 2 * (size.getX() + size.getY());
	}

	getRotation(): number {
		const points = this.getPoints();
		const dy = points[1].getY() - points[0].getY();
		const dx = points[1].getX() - points[0].getX();
		const angle = math.atan2(dy, dx);
		return angle;
	}

	getAxisAlignedRect(): GRect {
		const size = this.getSize();
		return GRect.createRectFromPoints(
			new Point2D(size.getX() / 2, size.getY() / 2),
			new Point2D(-size.getX() / 2, size.getY() / 2),
			new Point2D(-size.getX() / 2, -size.getY() / 2),
			new Point2D(size.getX() / 2, -size.getY() / 2),
		);
	}

	getBoundingBox(): GRect {
		const points = this.getPoints();
		const x = points.map((p) => p.getX());
		const y = points.map((p) => p.getY());
		const minX = math.min(...x);
		const maxX = math.max(...x);
		const minY = math.min(...y);
		const maxY = math.max(...y);
		return new GRect(
			new Point2D(minX, minY),
			new Point2D(maxX, minY),
			new Point2D(maxX, maxY),
			new Point2D(minX, maxY),
		);
	}

	isPointInside(point: Point2D): boolean {
		const [x, y] = GeneralMath.rotatePoint(point.getX(), point.getY(), -this.getRotation());
		const rotatedPoint = new Point2D(x, y);
		const axisAlignedRect = this.getAxisAlignedRect();
		const points = axisAlignedRect.getPoints();
		const xValues = points.map((p) => p.getX());
		const yValues = points.map((p) => p.getY());
		const minX = math.min(...xValues);
		const maxX = math.max(...xValues);
		const minY = math.min(...yValues);
		const maxY = math.max(...yValues);
		return rotatedPoint.getX() >= minX && rotatedPoint.getX() <= maxX && rotatedPoint.getY() >= minY && rotatedPoint.getY() <= maxY;
	}

	getCenter(): Point2D {
		return GeneralMath.centroid(this.getPoints());
	}

	intersects(segment: Segment): boolean {
		return this.getSides().some((side) => side.intersects(segment));
	}

	intersectsRect(rect: GRect): boolean {
		return this.getSides().some((side) => rect.intersects(side));
	}

	getIntersection(segment: Segment): Point2D | Segment | undefined {
		// Loop through each side of the rectangle and check for intersection
		const intersections = this.getSides().map((side: Segment) => side.getIntersection(segment));
		const nonUndefinedIntersections = new Array<Segment | Point2D>();
		for (const intersection of intersections) {
			if (intersection !== undefined) {
				nonUndefinedIntersections.push(intersection);
			}
		}

		// If the segment intersects, and the intersection is a segment, return the segment
		const segmentIntersections = nonUndefinedIntersections.filter(
			(intersection) => intersection instanceof Segment,
		);
		if (segmentIntersections.size() > 0) {
			return segmentIntersections[0];
		}

		// If the segment intersects, and the intersection is a point at the end of the segment, return the point
		const pointIntersections = nonUndefinedIntersections.filter(
			(intersection) => intersection instanceof Point2D,
		) as Point2D[];
		// If no intersections are found, return undefined
		// Because if there are no segment intersections, there will always be at least one point intersection
		if (pointIntersections.size() === 0) return undefined;

		// If the point intersections is only one, return the point
		if (pointIntersections.size() === 1) return pointIntersections[0];

		const intersectionAtRectCorner = this.getPoints().find((point) => {
			return pointIntersections.some((intersection) => {
				if (point.equals(intersection)) {
					return true;
				}
			});
		});
		if (intersectionAtRectCorner !== undefined) {
			return intersectionAtRectCorner;
		}

		// Else, find the next intersection, and return a segment from the first intersection to the next intersection
		const firstIntersection = pointIntersections[0];
		const secondIntersection = pointIntersections[1];
		return new Segment(firstIntersection, secondIntersection);
	}
}

export default GRect;
