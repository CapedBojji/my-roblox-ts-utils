import Point2D from "./Point";
import GeneralMath from "GeneralMath";

class Segment {
	private readonly p1: Point2D;
	private readonly p2: Point2D;

	constructor(p1: Point2D, p2: Point2D) {
		this.p1 = p1;
		this.p2 = p2;
	}

	getPoints(): [Point2D, Point2D] {
		return [this.p1, this.p2];
	}

	getSlope(): number | undefined {
		if (this.p1 === this.p2) return undefined;
		if (this.p1.getX() === this.p2.getX()) return undefined;
		if (this.p1.getY() === this.p2.getY()) return 0;
		return (this.p2.getY() - this.p1.getY()) / (this.p2.getX() - this.p1.getX());
	}

	getLength(): number {
		return math.sqrt(math.pow(this.p2.getX() - this.p1.getX(), 2) + math.pow(this.p2.getY() - this.p1.getY(), 2));
	}

	isVertical(): boolean {
		return this.p1.getX() === this.p2.getX();
	}

	isHorizontal(): boolean {
		return this.p1.getY() === this.p2.getY();
	}

	isParallelTo(segment: Segment): boolean {
		return this.getSlope() === segment.getSlope();
	}

	isPerpendicularTo(segment: Segment): boolean {
		if (this.isVertical() && segment.isHorizontal()) return true;
		if (this.isHorizontal() && segment.isVertical()) return true;
		return this.getSlope() === -1 / (segment.getSlope() as number);
	}

	xIntercept(): number | undefined {
		if (this.isHorizontal()) return undefined;
		if (this.isVertical()) return this.p1.getX();
		return -(this.yIntercept() as number) / (this.getSlope() as number);
	}

	yIntercept(): number | undefined {
		if (this.isVertical()) return undefined;
		if (this.isHorizontal()) return this.p1.getY();
		return this.p1.getY() - (this.getSlope() as number) * this.p1.getX();
	}

	equals(segment: Segment): boolean {
		if (this.p1.equals(segment.p1) && this.p2.equals(segment.p2)) return true;
		return this.p1.equals(segment.p2) && this.p2.equals(segment.p1);
	}

	isCollinearWith(segment: Segment): boolean {
		if (!this.isParallelTo(segment)) return false;
		if (this.isVertical()) return this.p1.getX() === segment.p1.getX();
		if (this.isHorizontal()) return this.p1.getY() === segment.p1.getY();
		return this.yIntercept() === segment.yIntercept();
	}

	containsPoint(point: Point2D): boolean {
		if (this.isVertical()) {
			if (point.getX() !== this.p1.getX()) return false;
			return (point.getY() >= this.p1.getY() && point.getY() <= this.p2.getY()) || (point.getY() <= this.p1.getY() && point.getY() >= this.p2.getY());
		}
		if (this.isHorizontal()) {
			if (point.getY() !== this.p1.getY()) return false;
			return (point.getX() >= this.p1.getX() && point.getX() <= this.p2.getX()) || (point.getX() <= this.p1.getX() && point.getX() >= this.p2.getX());
		}
		return (
			point.getY() === (this.getSlope() as number) * point.getX() + (this.yIntercept() as number) &&
			point.getX() >= math.min(this.p1.getX(), this.p2.getX()) &&
			point.getX() <= math.max(this.p1.getX(), this.p2.getX())
		);
	}

	intersects(segment: Segment): boolean {
		if (this.isParallelTo(segment) && !this.isCollinearWith(segment)) return false;
		if (this.isCollinearWith(segment)) {
			if (this.containsPoint(segment.p1)) return true;
			if (this.containsPoint(segment.p2)) return true;
			if (segment.containsPoint(this.p1)) return true;
			if (segment.containsPoint(this.p2)) return true;
			return false;
		}
		if (this.isPerpendicularTo(segment)) {
			// isPerpendicularTo only checks if the slopes are negative reciprocals
			// so we need to check if they intersect
			if (this.isVertical()) {
				const [minX, maxX] = [math.min(segment.p1.getX(), segment.p2.getX()), math.max(segment.p1.getX(), segment.p2.getX())];
				const [minY, maxY] = [math.min(this.p1.getY(), this.p2.getY()), math.max(this.p1.getY(), this.p2.getY())];
				return this.p1.getX() >= minX && this.p1.getX() <= maxX && segment.p1.getY() >= minY && segment.p1.getY() <= maxY;
			}
			if (segment.isVertical()) {
				const [minX, maxX] = [math.min(this.p1.getX(), this.p2.getX()), math.max(this.p1.getX(), this.p2.getX())];
				const [minY, maxY] = [math.min(segment.p1.getY(), segment.p2.getY()), math.max(segment.p1.getY(), segment.p2.getY())];
				return segment.p1.getX() >= minX && segment.p1.getX() <= maxX && this.p1.getY() >= minY && this.p1.getY() <= maxY;
			}
			const m1 = this.getSlope() as number;
			const m2 = segment.getSlope() as number;
			const b1 = this.yIntercept() as number;
			const b2 = segment.yIntercept() as number;
			const x = GeneralMath.getX_2MB(m1, b1, m2, b2);
			const y = m1 * x + b1;
			return this.containsPoint(new Point2D(x, y)) && segment.containsPoint(new Point2D(x, y));
		}
		// Case where one segment is vertical and the other is not
		if (this.isVertical()) {
			const m = segment.getSlope() as number;
			const b = segment.yIntercept() as number;
			const x = this.p1.getX();
			const y = GeneralMath.getY_XMB(x, m, b);
			return this.containsPoint(new Point2D(x, y)) && segment.containsPoint(new Point2D(x, y));
		}

		if (segment.isVertical()) {
			const m = this.getSlope() as number;
			const b = this.yIntercept() as number;
			const x = segment.p1.getX();
			const y = GeneralMath.getY_XMB(x, m, b);
			return this.containsPoint(new Point2D(x, y)) && segment.containsPoint(new Point2D(x, y));
		}

		// Case where one segment is horizontal and the other is not
		if (this.isHorizontal()) {
			const m = segment.getSlope() as number;
			const b = segment.yIntercept() as number;
			const y = this.p1.getY();
			const x = GeneralMath.getX_YMB(y, m, b);
			return this.containsPoint(new Point2D(x, y)) && segment.containsPoint(new Point2D(x, y));
		}

		if (segment.isHorizontal()) {
			const m = this.getSlope() as number;
			const b = this.yIntercept() as number;
			const y = segment.p1.getY();
			const x = GeneralMath.getX_YMB(y, m, b);
			return this.containsPoint(new Point2D(x, y)) && segment.containsPoint(new Point2D(x, y));
		}

		// All edge cases have been handled, so we can assume that both segments are neither vertical nor horizontal
		const m1 = this.getSlope() as number;
		const m2 = segment.getSlope() as number;
		const b1 = this.yIntercept() as number;
		const b2 = segment.yIntercept() as number;
		const x = GeneralMath.getX_2MB(m1, b1, m2, b2);
		const y = m1 * x + b1;
		return this.containsPoint(new Point2D(x, y)) && segment.containsPoint(new Point2D(x, y));
	}

	getIntersection(segment: Segment): Point2D | Segment | undefined {
		if (!this.intersects(segment)) return undefined;
		// The segments are guaranteed to intersect
		if (this.isCollinearWith(segment)) {
			const [p1, p2, p3, p4] = [this.p1, this.p2, segment.p1, segment.p2];
			// If vertical, sort by Y
			if (this.isVertical()) {
				const points = [p1, p2, p3, p4].sort((a, b) => a.getY() > b.getY());
				if (points[1].equals(points[2])) return points[1];
				return new Segment(points[1], points[2]);
			}
			// Sort by X
			const points = [p1, p2, p3, p4].sort((a, b) => a.getX() > b.getX());
			if (points[1].equals(points[2])) return points[1];
			return new Segment(points[1], points[2]);
		}
		if (this.isPerpendicularTo(segment)) {
			if (this.isVertical()) {
				return new Point2D(this.p1.getX(), segment.p1.getY());
			}
			if (segment.isVertical()) return new Point2D(segment.p1.getX(), this.p1.getY());
			// Both segments are neither vertical nor horizontal
		}
		// All edge cases have been handled, so we can assume that both segments are neither vertical nor horizontal
		const m1 = this.getSlope() as number;
		const m2 = segment.getSlope() as number;
		const b1 = this.yIntercept() as number;
		const b2 = segment.yIntercept() as number;
		const x = GeneralMath.getX_2MB(m1, b1, m2, b2);
		const y = m1 * x + b1;
		return new Point2D(x, y);
	}
}

export default Segment;
