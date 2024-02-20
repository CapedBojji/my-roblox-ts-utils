import Point2D from "Point";

function getXWhereTwoLinesIntersectGivenSlopeAndYIntercept(m1: number, b1: number, m2: number, b2: number): number {
	return (b2 - b1) / (m1 - m2);
}

function findYGivenXAndSlopeIntercept(x: number, m: number, b: number): number {
	return m * x + b;
}

function findXGivenYAndSlopeIntercept(y: number, m: number, b: number): number {
	return (y - b) / m;
}

function centroid(points: Point2D[]): Point2D {
	let x = 0;
	let y = 0;
	points.forEach((p) => {
		x += p.getX();
		y += p.getY();
	});
	return new Point2D(x / points.size(), y / points.size());
}

function angleOfLineBetweenTwoPoints(p1: Point2D, p2: Point2D): number {
	return math.atan2(p2.getY() - p1.getY(), p2.getX() - p1.getX());
}

function distanceBetweenTwoPoints(p1: Point2D, p2: Point2D): number {
	return math.sqrt(math.pow(p2.getX() - p1.getX(), 2) + math.pow(p2.getY() - p1.getY(), 2));
}

function rotatePoint(x: number, y: number, angle: number): [number, number] {
	const newX = x * math.cos(angle) - y * math.sin(angle);
	const newY = x * math.sin(angle) + y * math.cos(angle);
	return [newX, newY];
}

const GeneralMath = {
	getX_2MB: getXWhereTwoLinesIntersectGivenSlopeAndYIntercept,
	getY_XMB: findYGivenXAndSlopeIntercept,
	getX_YMB: findXGivenYAndSlopeIntercept,
	centroid: centroid,
	getAngle_2Points: angleOfLineBetweenTwoPoints,
	getDistance_2Points: distanceBetweenTwoPoints,
	rotatePoint: rotatePoint,
};

export default GeneralMath;
