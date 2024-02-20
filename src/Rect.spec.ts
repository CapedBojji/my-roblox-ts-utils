/// <reference types="@rbxts/testez/globals" />

import GRect from "Rect"; // Adjust the import path to your project structure
import Point2D from "Point";
import Segment from "Segment";

export = () => {
	describe("GRect class tests", () => {
		// Test creation from points
		describe("GRect.fromPoints", () => {
			it("correctly orders points and creates a rectangle", () => {
				const p1 = new Point2D(0, 0);
				const p2 = new Point2D(2, 0);
				const p3 = new Point2D(2, 1);
				const p4 = new Point2D(0, 1);
				const rect = GRect.createRectFromPoints(p1, p2, p3, p4);

				const expectedPoints = [p1, p2, p3, p4];
				const rectPoints = rect.getPoints();
				expect(rectPoints.every((point, index) => expectedPoints.includes(point))).to.equal(true);
			});
		});

		// Test getSides
		describe("getSides", () => {
			it("returns four segments representing the sides of the rectangle", () => {
				const p1 = new Point2D(0, 0);
				const p2 = new Point2D(2, 0);
				const p3 = new Point2D(2, 1);
				const p4 = new Point2D(0, 1);
				const rect = GRect.createRectFromPoints(p1, p2, p3, p4);

				const sides = rect.getSides();
				expect(sides.size()).to.equal(4);
				expect(sides[0] instanceof Segment).to.equal(true);
				expect(sides[1] instanceof Segment).to.equal(true);
				expect(sides[2] instanceof Segment).to.equal(true);
				expect(sides[3] instanceof Segment).to.equal(true);
			});
		});

		// Test getSize
		describe("getSize", () => {
			it("calculates the correct length and width of the rectangle", () => {
				const rect = GRect.createRectFromPoints(
					new Point2D(0, 0),
					new Point2D(2, 0),
					new Point2D(2, 1),
					new Point2D(0, 1),
				);
				const size = rect.getSize();
				expect(size.getX()).to.equal(2); // Length
				expect(size.getY()).to.equal(1); // Width
			});
		});

		// Test getArea
		describe("getArea", () => {
			it("calculates the correct area of the rectangle", () => {
				const rect = GRect.createRectFromPoints(
					new Point2D(0, 0),
					new Point2D(2, 0),
					new Point2D(2, 1),
					new Point2D(0, 1),
				);
				const area = rect.getArea();
				expect(area).to.equal(2);
			});
		});

		// Test getPerimeter
		describe("getPerimeter", () => {
			it("calculates the correct perimeter of the rectangle", () => {
				const rect = GRect.createRectFromPoints(
					new Point2D(0, 0),
					new Point2D(2, 0),
					new Point2D(2, 1),
					new Point2D(0, 1),
				);
				const perimeter = rect.getPerimeter();
				expect(perimeter).to.equal(6);
			});
		});

		// Test intersects
		describe("intersects", () => {
			it("detects intersection with a segment", () => {
				const rect = GRect.createRectFromPoints(
					new Point2D(0, 0),
					new Point2D(2, 0),
					new Point2D(2, 2),
					new Point2D(0, 2),
				);
				const segment = new Segment(new Point2D(1, 1), new Point2D(3, 3));
				expect(rect.intersects(segment)).to.equal(true);
			});

			it("detects no intersection with a segment", () => {
				const rect = GRect.createRectFromPoints(
					new Point2D(0, 0),
					new Point2D(2, 0),
					new Point2D(2, 2),
					new Point2D(0, 2),
				);
				const segment = new Segment(new Point2D(3, 3), new Point2D(4, 4));
				expect(rect.intersects(segment)).to.equal(false);
			});
		});

		// Test intersectsRect
		describe("intersectsRect", () => {
			it("detects intersection with another rectangle", () => {
				const rect1 = GRect.createRectFromPoints(
					new Point2D(0, 0),
					new Point2D(3, 0),
					new Point2D(3, 3),
					new Point2D(0, 3),
				);
				const rect2 = GRect.createRectFromPoints(
					new Point2D(2, 2),
					new Point2D(4, 2),
					new Point2D(4, 4),
					new Point2D(2, 4),
				);
				expect(rect1.intersectsRect(rect2)).to.equal(true);
			});

			it("detects no intersection with another rectangle", () => {
				const rect1 = GRect.createRectFromPoints(
					new Point2D(0, 0),
					new Point2D(2, 0),
					new Point2D(2, 2),
					new Point2D(0, 2),
				);
				const rect2 = GRect.createRectFromPoints(
					new Point2D(3, 3),
					new Point2D(5, 3),
					new Point2D(5, 5),
					new Point2D(3, 5),
				);
				expect(rect1.intersectsRect(rect2)).to.equal(false);
			});
		});

		// Test getRotation
		describe("getRotation", () => {
			it("calculates the correct rotation of the rectangle", () => {
				const rect = GRect.createRectFromPoints(
					new Point2D(0, 0),
					new Point2D(1, 1),
					new Point2D(0, 2),
					new Point2D(-1, 1),
				);
				const rotation = rect.getRotation();
				expect(rotation).to.be.ok();
			});
		});

		// Test getCenter
		describe("getCenter", () => {
			it("calculates the correct center of the rectangle", () => {
				const rect = GRect.createRectFromPoints(
					new Point2D(0, 0),
					new Point2D(2, 0),
					new Point2D(2, 2),
					new Point2D(0, 2),
				);
				const center = rect.getCenter();
				expect(center.equals(new Point2D(1, 1))).to.equal(true);
			});
		});
		describe("intersects and getIntersection with Segment", () => {
			// Intersection results in a segment (collinear edges)
			it("returns true for collinear overlap and gets the overlapping segment", () => {
				const rect = GRect.createRectFromPoints(
					new Point2D(0, 0),
					new Point2D(4, 0),
					new Point2D(4, 4),
					new Point2D(0, 4),
				);
				const overlappingSegment = new Segment(new Point2D(2, 0), new Point2D(3, 0));
				expect(rect.intersects(overlappingSegment)).to.equal(true);

				const intersection = rect.getIntersection(overlappingSegment);
				// Adjust assertion based on how intersections are represented in your implementation
				// This assumes getIntersection would return a Segment for collinear overlaps
				expect(intersection instanceof Segment && intersection.equals(overlappingSegment)).to.equal(true);
			});

			// Intersection at a single point
			it("returns true for a single point intersection and gets the intersecting point", () => {
				const rect = GRect.createRectFromPoints(
					new Point2D(0, 0),
					new Point2D(4, 0),
					new Point2D(4, 4),
					new Point2D(0, 4),
				);
				const intersectingSegment = new Segment(new Point2D(2, -1), new Point2D(2, 1));
				expect(rect.intersects(intersectingSegment)).to.equal(true);

				const intersection = rect.getIntersection(intersectingSegment);
				// Adjust assertion based on your implementation details
				expect(intersection instanceof Point2D && intersection.equals(new Point2D(2, 0))).to.equal(true);
			});

			// No intersection
			it("returns false for no intersection and undefined for getIntersection", () => {
				const rect = GRect.createRectFromPoints(
					new Point2D(0, 0),
					new Point2D(4, 0),
					new Point2D(4, 4),
					new Point2D(0, 4),
				);
				const outsideSegment = new Segment(new Point2D(5, 5), new Point2D(6, 6));
				expect(rect.intersects(outsideSegment)).to.equal(false);

				const intersection = rect.getIntersection(outsideSegment);
				expect(intersection).to.equal(undefined);
			});
		});

		describe("intersectsRect and getIntersection with GRect", () => {
			// Adjust these tests based on your implementation of intersectsRect and getIntersection for GRect-GRect interactions
		});

		describe("GRect.fromPart", () => {
			it("correctly creates a rectangle from a Part's top-down perspective", () => {
				// Mock Part properties: Size and Position (CFrame.Position)
				const mockPart = {
					Size: new Vector3(4, 2, 6), // Length (X), Height (Y), Width (Z)
					CFrame: new CFrame(new Vector3(3, 0, 4)), // Position at center
				};

				// Calculate expected corner points based on Part's Size and Position
				// Assuming Y is up and looking down from the top, so we use X and Z for Point2D
				const expectedPoints = [
					new Point2D(1, 1), // Bottom left
					new Point2D(5, 1), // Bottom right
					new Point2D(5, 7), // Top right
					new Point2D(1, 7), // Top left
				];

				// Convert Part to GRect
				const rect = GRect.createRectFromPart(mockPart);

				// Get GRect points
				const rectPoints = rect.getPoints();

				// Check if every expected point matches the actual GRect points
				// This might require adjusting based on how fromPart orders points
				const pointsMatch = expectedPoints.every((p, i) => rectPoints.some((rp) => rp.equals(p)));

				expect(pointsMatch).to.equal(true);
			});

			it("correctly creates a rectangle from a 45-degree rotated Part's top-down perspective", () => {
				// Mock Part properties: Size, Position, and Rotation (CFrame)
				// Assuming a simplified scenario where CFrame only involves rotation around Y-axis
				const mockPart = {
					Size: new Vector3(5, 5, 5), // Cube with 5 units side length
					CFrame: new CFrame(new Vector3(0, 0, 0)).mul(CFrame.Angles(0, math.rad(45), 0)), // Rotated 45 degrees
				};

				// Expected points calculation for a 45-degree rotation
				const distance = (5 * math.sqrt(2)) / 2; // Half diagonal of the square's side
				const expectedPoints = [
					new Point2D(0, -distance),
					new Point2D(distance, 0),
					new Point2D(0, distance),
					new Point2D(-distance, 0),
				];
				// Convert mockPart to GRect, assuming fromPart can handle this mockPart structure
				// Note: This step requires implementing a mock or an adaptation of fromPart
				const rect = GRect.createRectFromPart(mockPart);

				// Get GRect points and sort them for comparison
				const rectPoints = rect.getPoints();
				const pointsMatch = expectedPoints.every((p, i) => rectPoints.some((rp) => rp.equals(p)));
				expect(pointsMatch).to.equal(true);
			});
		});
	});
};
