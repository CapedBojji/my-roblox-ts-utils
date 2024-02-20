
/// <reference types="@rbxts/testez/globals" />

import Segment from "Segment"; // Use the correct import path for your project
import Point2D from "Point"; // Assuming Point2D is also in shared/Utils

export = () => {
	describe("Segment methods", () => {
		describe("Segment.getSlope", () => {
			it("calculates positive slope correctly", () => {
				const segment = new Segment(new Point2D(1, 1), new Point2D(2, 3));
				const slope = segment.getSlope();
				expect(slope).to.equal(2);
			});

			it("calculates negative slope correctly", () => {
				const segment = new Segment(new Point2D(1, 3), new Point2D(2, 1));
				const slope = segment.getSlope();
				expect(slope).to.equal(-2);
			});

			it("returns 0 for horizontal lines", () => {
				const segment = new Segment(new Point2D(1, 1), new Point2D(3, 1));
				const slope = segment.getSlope();
				expect(slope).to.equal(0);
			});

			it("returns undefined for vertical lines", () => {
				const segment = new Segment(new Point2D(1, 1), new Point2D(1, 3));
				const slope = segment.getSlope();
				expect(slope).never.to.be.ok();
			});

			it("returns undefined for identical points", () => {
				const segment = new Segment(new Point2D(1, 1), new Point2D(1, 1));
				const slope = segment.getSlope();
				expect(slope).never.to.be.ok();
			});
		});
		// Test for isVertical
		describe("isVertical", () => {
			it("should return true for vertical lines", () => {
				const segment = new Segment(new Point2D(1, 1), new Point2D(1, 3));
				expect(segment.isVertical()).to.equal(true);
			});

			it("should return false for non-vertical lines", () => {
				const segment = new Segment(new Point2D(1, 1), new Point2D(2, 3));
				expect(segment.isVertical()).to.equal(false);
			});
		});

		// Test for getLength
		describe("getLength", () => {
			it("calculates length correctly", () => {
				const segment = new Segment(new Point2D(0, 0), new Point2D(3, 4)); // Should form a 3-4-5 triangle
				expect(segment.getLength()).to.be.near(5, 1e-6);
			});
		});

		// Test for isHorizontal
		describe("isHorizontal", () => {
			it("should return true for horizontal lines", () => {
				const segment = new Segment(new Point2D(1, 1), new Point2D(3, 1));
				expect(segment.isHorizontal()).to.equal(true);
			});

			it("should return false for non-horizontal lines", () => {
				const segment = new Segment(new Point2D(1, 1), new Point2D(1, 3));
				expect(segment.isHorizontal()).to.equal(false);
			});
		});

		// Test for isParallelTo
		describe("isParallelTo", () => {
			it("should return true for parallel segments", () => {
				const segment1 = new Segment(new Point2D(1, 1), new Point2D(2, 2));
				const segment2 = new Segment(new Point2D(2, 2), new Point2D(3, 3));
				expect(segment1.isParallelTo(segment2)).to.equal(true);
			});

			it("should return false for non-parallel segments", () => {
				const segment1 = new Segment(new Point2D(1, 1), new Point2D(2, 2));
				const segment2 = new Segment(new Point2D(1, 1), new Point2D(2, 3));
				expect(segment1.isParallelTo(segment2)).to.equal(false);
			});

			it("should return true for vertical parallel segments", () => {
				const segment1 = new Segment(new Point2D(1, 1), new Point2D(1, 3));
				const segment2 = new Segment(new Point2D(2, 2), new Point2D(2, 4));
				expect(segment1.isParallelTo(segment2)).to.equal(true);
			});

			it("should return true for horizontal parallel segments", () => {
				const segment1 = new Segment(new Point2D(1, 1), new Point2D(3, 1));
				const segment2 = new Segment(new Point2D(2, 1), new Point2D(4, 1));
				expect(segment1.isParallelTo(segment2)).to.equal(true);
			});
		});
		// X-Intercept and Y-Intercept Tests
		describe("xIntercept and yIntercept methods", () => {
			it("calculates x-intercept correctly", () => {
				const segment = new Segment(new Point2D(0, 2), new Point2D(2, 0));
				expect(segment.xIntercept()).to.equal(2);
			});

			it("calculates y-intercept correctly", () => {
				const segment = new Segment(new Point2D(0, 2), new Point2D(2, 0));
				expect(segment.yIntercept()).to.equal(2);
			});

			it("returns undefined for y-intercept of a vertical line", () => {
				const segment = new Segment(new Point2D(1, 1), new Point2D(1, 3));
				expect(segment.yIntercept()).never.to.be.ok();
			});

			it("returns undefined for x-intercept of a horizontal line", () => {
				const segment = new Segment(new Point2D(1, 1), new Point2D(3, 1));
				expect(segment.xIntercept()).never.to.be.ok();
			});
		});

		// Equals Tests
		describe("equals method", () => {
			it("recognizes two identical segments as equal", () => {
				const segment1 = new Segment(new Point2D(1, 1), new Point2D(2, 2));
				const segment2 = new Segment(new Point2D(1, 1), new Point2D(2, 2));
				expect(segment1.equals(segment2)).to.equal(true);
			});

			it("recognizes two different segments as not equal", () => {
				const segment1 = new Segment(new Point2D(1, 1), new Point2D(2, 2));
				const segment2 = new Segment(new Point2D(1, 2), new Point2D(2, 3));
				expect(segment1.equals(segment2)).to.equal(false);
			});
		});

		// isCollinearWith Tests
		describe("isCollinearWith method", () => {
			it("identifies collinear segments", () => {
				const segment1 = new Segment(new Point2D(0, 0), new Point2D(1, 1));
				const segment2 = new Segment(new Point2D(2, 2), new Point2D(3, 3));
				expect(segment1.isCollinearWith(segment2)).to.equal(true);
			});

			it("identifies non-collinear segments", () => {
				const segment1 = new Segment(new Point2D(0, 0), new Point2D(1, 1));
				const segment2 = new Segment(new Point2D(1, 0), new Point2D(2, 2));
				expect(segment1.isCollinearWith(segment2)).to.equal(false);
			});
		});

		// containsPoint Tests
		describe("containsPoint method", () => {
			it("confirms a point on the segment", () => {
				const segment = new Segment(new Point2D(0, 0), new Point2D(2, 2));
				const point = new Point2D(1, 1);
				expect(segment.containsPoint(point)).to.equal(true);
			});

			it("rejects a point not on the segment", () => {
				const segment = new Segment(new Point2D(0, 0), new Point2D(2, 2));
				const point = new Point2D(2, 1);
				expect(segment.containsPoint(point)).to.equal(false);
			});

			it("confirms a point on a horizontal segment", () => {
				const segment = new Segment(new Point2D(0, 0), new Point2D(2, 0));
				const point = new Point2D(1, 0);
				expect(segment.containsPoint(point)).to.equal(true);
			});

			it("confirms a point on a vertical segment", () => {
				const segment = new Segment(new Point2D(0, 0), new Point2D(0, 2));
				const point = new Point2D(0, 1);
				expect(segment.containsPoint(point)).to.equal(true);
			});
		});
		// getIntersection Method Tests
		describe("getIntersection method scenarios", () => {
			it("returns the correct intersection point for segments that intersect normally", () => {
				const segment1 = new Segment(new Point2D(0, 0), new Point2D(2, 2));
				const segment2 = new Segment(new Point2D(0, 2), new Point2D(2, 0));
				const intersection = segment1.getIntersection(segment2);
				expect((intersection as Point2D)?.equals(new Point2D(1, 1))).to.equal(true);
			});

			it("returns undefined for parallel segments that do not intersect", () => {
				const segment1 = new Segment(new Point2D(0, 0), new Point2D(2, 2));
				const segment2 = new Segment(new Point2D(0, 1), new Point2D(2, 3));
				const intersection = segment1.getIntersection(segment2);
				expect(intersection).never.to.be.ok();
			});

			it("returns the overlapping segment for collinear segments that overlap", () => {
				// Assuming getIntersection returns a Segment for overlapping collinear segments
				const segment1 = new Segment(new Point2D(0, 0), new Point2D(2, 2));
				const segment2 = new Segment(new Point2D(1, 1), new Point2D(3, 3));
				const intersection = segment1.getIntersection(segment2);
				// Validate that the intersection is a segment from (1, 1) to (2, 2)
				const expectedStart = new Point2D(1, 1);
				const expectedEnd = new Point2D(2, 2);
				expect(
					((intersection as Segment).getPoints()[0].equals(expectedStart) &&
						(intersection as Segment).getPoints()[1].equals(expectedEnd)) ||
						((intersection as Segment).getPoints()[0].equals(expectedEnd) &&
							(intersection as Segment).getPoints()[1].equals(expectedStart)),
				).to.equal(true);
			});

			it("returns undefined for collinear segments that do not overlap", () => {
				const segment1 = new Segment(new Point2D(0, 0), new Point2D(1, 1));
				const segment2 = new Segment(new Point2D(2, 2), new Point2D(3, 3));
				const intersection = segment1.getIntersection(segment2);
				expect(intersection).never.to.be.ok();
			});

			it("returns the correct intersection point for segments that are perpendicular", () => {
				const segment1 = new Segment(new Point2D(0, 1), new Point2D(2, 1));
				const segment2 = new Segment(new Point2D(1, 0), new Point2D(1, 2));
				const intersection = segment1.getIntersection(segment2);
				expect((intersection as Point2D)?.equals(new Point2D(1, 1))).to.equal(true);
			});

			it("handles intersection when one segment is vertical", () => {
				const segment1 = new Segment(new Point2D(1, 0), new Point2D(1, 2));
				const segment2 = new Segment(new Point2D(0, 1), new Point2D(2, 1));
				const intersection = segment1.getIntersection(segment2);
				expect((intersection as Point2D)?.equals(new Point2D(1, 1))).to.equal(true);
			});

			it("handles intersection when one segment is horizontal", () => {
				const segment1 = new Segment(new Point2D(0, 1), new Point2D(2, 1));
				const segment2 = new Segment(new Point2D(1, 0), new Point2D(1, 2));
				const intersection = segment1.getIntersection(segment2);
				expect((intersection as Point2D)?.equals(new Point2D(1, 1))).to.equal(true);
			});

			it("returns undefined for segments that do not intersect with one being vertical", () => {
				const segment1 = new Segment(new Point2D(1, 0), new Point2D(1, 2));
				const segment2 = new Segment(new Point2D(2, 0), new Point2D(2, 3));
				const intersection = segment1.getIntersection(segment2);
				expect(intersection).never.to.be.ok();
			});

			it("returns undefined for segments that do not intersect with one being horizontal", () => {
				const segment1 = new Segment(new Point2D(0, 1), new Point2D(2, 1));
				const segment2 = new Segment(new Point2D(0, 2), new Point2D(3, 2));
				const intersection = segment1.getIntersection(segment2);
				expect(intersection).never.to.be.ok();
			});
		});
	});
};
