class Point2D {
	private readonly point: Vector2;
	private readonly X: number;
	private readonly Y: number;

	constructor(x: number, y: number) {
		this.point = new Vector2(x, y);
		this.X = x;
		this.Y = y;
	}

	equals(point: Point2D): boolean {
		return this.point.X === point.point.X && this.point.Y === point.point.Y;
	}

	getX(): number {
		return this.point.X;
	}

	getY(): number {
		return this.point.Y;
	}

	toVector2(): Vector2 {
		return this.point;
	}

	add(point: Point2D): Point2D {
		return new Point2D(this.X + point.X, this.Y + point.Y);
	}

	subtract(point: Point2D): Point2D {
		return new Point2D(this.X - point.X, this.Y - point.Y);
	}

	dividedBy(value: number): Point2D {
		return new Point2D(this.X / value, this.Y / value);
	}
}

export default Point2D;
