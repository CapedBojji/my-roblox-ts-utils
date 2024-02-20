-- Compiled with roblox-ts v2.3.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
--/ <reference types="@rbxts/testez/globals" />
local GRect = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Rect").default
local Point2D = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Point").default
local Segment = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Segment").default
return function()
	describe("GRect class tests", function()
		-- Test creation from points
		describe("GRect.fromPoints", function()
			it("correctly orders points and creates a rectangle", function()
				local p1 = Point2D.new(0, 0)
				local p2 = Point2D.new(2, 0)
				local p3 = Point2D.new(2, 1)
				local p4 = Point2D.new(0, 1)
				local rect = GRect:createRectFromPoints(p1, p2, p3, p4)
				local expectedPoints = { p1, p2, p3, p4 }
				local rectPoints = rect:getPoints()
				-- ▼ ReadonlyArray.every ▼
				local _result = true
				local _callback = function(point, index)
					local _point = point
					return table.find(expectedPoints, _point) ~= nil
				end
				for _k, _v in rectPoints do
					if not _callback(_v, _k - 1, rectPoints) then
						_result = false
						break
					end
				end
				-- ▲ ReadonlyArray.every ▲
				expect(_result).to.equal(true)
			end)
		end)
		-- Test getSides
		describe("getSides", function()
			it("returns four segments representing the sides of the rectangle", function()
				local p1 = Point2D.new(0, 0)
				local p2 = Point2D.new(2, 0)
				local p3 = Point2D.new(2, 1)
				local p4 = Point2D.new(0, 1)
				local rect = GRect:createRectFromPoints(p1, p2, p3, p4)
				local sides = rect:getSides()
				expect(#sides).to.equal(4)
				expect(TS.instanceof(sides[1], Segment)).to.equal(true)
				expect(TS.instanceof(sides[2], Segment)).to.equal(true)
				expect(TS.instanceof(sides[3], Segment)).to.equal(true)
				expect(TS.instanceof(sides[4], Segment)).to.equal(true)
			end)
		end)
		-- Test getSize
		describe("getSize", function()
			it("calculates the correct length and width of the rectangle", function()
				local rect = GRect:createRectFromPoints(Point2D.new(0, 0), Point2D.new(2, 0), Point2D.new(2, 1), Point2D.new(0, 1))
				local size = rect:getSize()
				expect(size:getX()).to.equal(2)
				expect(size:getY()).to.equal(1)
			end)
		end)
		-- Test getArea
		describe("getArea", function()
			it("calculates the correct area of the rectangle", function()
				local rect = GRect:createRectFromPoints(Point2D.new(0, 0), Point2D.new(2, 0), Point2D.new(2, 1), Point2D.new(0, 1))
				local area = rect:getArea()
				expect(area).to.equal(2)
			end)
		end)
		-- Test getPerimeter
		describe("getPerimeter", function()
			it("calculates the correct perimeter of the rectangle", function()
				local rect = GRect:createRectFromPoints(Point2D.new(0, 0), Point2D.new(2, 0), Point2D.new(2, 1), Point2D.new(0, 1))
				local perimeter = rect:getPerimeter()
				expect(perimeter).to.equal(6)
			end)
		end)
		-- Test intersects
		describe("intersects", function()
			it("detects intersection with a segment", function()
				local rect = GRect:createRectFromPoints(Point2D.new(0, 0), Point2D.new(2, 0), Point2D.new(2, 2), Point2D.new(0, 2))
				local segment = Segment.new(Point2D.new(1, 1), Point2D.new(3, 3))
				expect(rect:intersects(segment)).to.equal(true)
			end)
			it("detects no intersection with a segment", function()
				local rect = GRect:createRectFromPoints(Point2D.new(0, 0), Point2D.new(2, 0), Point2D.new(2, 2), Point2D.new(0, 2))
				local segment = Segment.new(Point2D.new(3, 3), Point2D.new(4, 4))
				expect(rect:intersects(segment)).to.equal(false)
			end)
		end)
		-- Test intersectsRect
		describe("intersectsRect", function()
			it("detects intersection with another rectangle", function()
				local rect1 = GRect:createRectFromPoints(Point2D.new(0, 0), Point2D.new(3, 0), Point2D.new(3, 3), Point2D.new(0, 3))
				local rect2 = GRect:createRectFromPoints(Point2D.new(2, 2), Point2D.new(4, 2), Point2D.new(4, 4), Point2D.new(2, 4))
				expect(rect1:intersectsRect(rect2)).to.equal(true)
			end)
			it("detects no intersection with another rectangle", function()
				local rect1 = GRect:createRectFromPoints(Point2D.new(0, 0), Point2D.new(2, 0), Point2D.new(2, 2), Point2D.new(0, 2))
				local rect2 = GRect:createRectFromPoints(Point2D.new(3, 3), Point2D.new(5, 3), Point2D.new(5, 5), Point2D.new(3, 5))
				expect(rect1:intersectsRect(rect2)).to.equal(false)
			end)
		end)
		-- Test getRotation
		describe("getRotation", function()
			it("calculates the correct rotation of the rectangle", function()
				local rect = GRect:createRectFromPoints(Point2D.new(0, 0), Point2D.new(1, 1), Point2D.new(0, 2), Point2D.new(-1, 1))
				local rotation = rect:getRotation()
				expect(rotation).to.be.ok()
			end)
		end)
		-- Test getCenter
		describe("getCenter", function()
			it("calculates the correct center of the rectangle", function()
				local rect = GRect:createRectFromPoints(Point2D.new(0, 0), Point2D.new(2, 0), Point2D.new(2, 2), Point2D.new(0, 2))
				local center = rect:getCenter()
				expect(center:equals(Point2D.new(1, 1))).to.equal(true)
			end)
		end)
		describe("intersects and getIntersection with Segment", function()
			-- Intersection results in a segment (collinear edges)
			it("returns true for collinear overlap and gets the overlapping segment", function()
				local rect = GRect:createRectFromPoints(Point2D.new(0, 0), Point2D.new(4, 0), Point2D.new(4, 4), Point2D.new(0, 4))
				local overlappingSegment = Segment.new(Point2D.new(2, 0), Point2D.new(3, 0))
				expect(rect:intersects(overlappingSegment)).to.equal(true)
				local intersection = rect:getIntersection(overlappingSegment)
				-- Adjust assertion based on how intersections are represented in your implementation
				-- This assumes getIntersection would return a Segment for collinear overlaps
				expect(TS.instanceof(intersection, Segment) and intersection:equals(overlappingSegment)).to.equal(true)
			end)
			-- Intersection at a single point
			it("returns true for a single point intersection and gets the intersecting point", function()
				local rect = GRect:createRectFromPoints(Point2D.new(0, 0), Point2D.new(4, 0), Point2D.new(4, 4), Point2D.new(0, 4))
				local intersectingSegment = Segment.new(Point2D.new(2, -1), Point2D.new(2, 1))
				expect(rect:intersects(intersectingSegment)).to.equal(true)
				local intersection = rect:getIntersection(intersectingSegment)
				-- Adjust assertion based on your implementation details
				expect(TS.instanceof(intersection, Point2D) and intersection:equals(Point2D.new(2, 0))).to.equal(true)
			end)
			-- No intersection
			it("returns false for no intersection and undefined for getIntersection", function()
				local rect = GRect:createRectFromPoints(Point2D.new(0, 0), Point2D.new(4, 0), Point2D.new(4, 4), Point2D.new(0, 4))
				local outsideSegment = Segment.new(Point2D.new(5, 5), Point2D.new(6, 6))
				expect(rect:intersects(outsideSegment)).to.equal(false)
				local intersection = rect:getIntersection(outsideSegment)
				expect(intersection).to.equal(nil)
			end)
		end)
		describe("intersectsRect and getIntersection with GRect", function()
			-- Adjust these tests based on your implementation of intersectsRect and getIntersection for GRect-GRect interactions
		end)
		describe("GRect.fromPart", function()
			it("correctly creates a rectangle from a Part's top-down perspective", function()
				-- Mock Part properties: Size and Position (CFrame.Position)
				local mockPart = {
					Size = Vector3.new(4, 2, 6),
					CFrame = CFrame.new(Vector3.new(3, 0, 4)),
				}
				-- Calculate expected corner points based on Part's Size and Position
				-- Assuming Y is up and looking down from the top, so we use X and Z for Point2D
				local expectedPoints = { Point2D.new(1, 1), Point2D.new(5, 1), Point2D.new(5, 7), Point2D.new(1, 7) }
				-- Convert Part to GRect
				local rect = GRect:createRectFromPart(mockPart)
				-- Get GRect points
				local rectPoints = rect:getPoints()
				-- Check if every expected point matches the actual GRect points
				-- This might require adjusting based on how fromPart orders points
				-- ▼ ReadonlyArray.every ▼
				local _result = true
				local _callback = function(p, i)
					-- ▼ ReadonlyArray.some ▼
					local _result_1 = false
					local _callback_1 = function(rp)
						return rp:equals(p)
					end
					for _k, _v in rectPoints do
						if _callback_1(_v, _k - 1, rectPoints) then
							_result_1 = true
							break
						end
					end
					-- ▲ ReadonlyArray.some ▲
					return _result_1
				end
				for _k, _v in expectedPoints do
					if not _callback(_v, _k - 1, expectedPoints) then
						_result = false
						break
					end
				end
				-- ▲ ReadonlyArray.every ▲
				local pointsMatch = _result
				expect(pointsMatch).to.equal(true)
			end)
			it("correctly creates a rectangle from a 45-degree rotated Part's top-down perspective", function()
				-- Mock Part properties: Size, Position, and Rotation (CFrame)
				-- Assuming a simplified scenario where CFrame only involves rotation around Y-axis
				local _object = {
					Size = Vector3.new(5, 5, 5),
				}
				local _left = "CFrame"
				local _cFrame = CFrame.new(Vector3.new(0, 0, 0))
				local _arg0 = CFrame.Angles(0, math.rad(45), 0)
				_object[_left] = _cFrame * _arg0
				local mockPart = _object
				-- Expected points calculation for a 45-degree rotation
				local distance = (5 * math.sqrt(2)) / 2
				local expectedPoints = { Point2D.new(0, -distance), Point2D.new(distance, 0), Point2D.new(0, distance), Point2D.new(-distance, 0) }
				-- Convert mockPart to GRect, assuming fromPart can handle this mockPart structure
				-- Note: This step requires implementing a mock or an adaptation of fromPart
				local rect = GRect:createRectFromPart(mockPart)
				-- Get GRect points and sort them for comparison
				local rectPoints = rect:getPoints()
				-- ▼ ReadonlyArray.every ▼
				local _result = true
				local _callback = function(p, i)
					-- ▼ ReadonlyArray.some ▼
					local _result_1 = false
					local _callback_1 = function(rp)
						return rp:equals(p)
					end
					for _k, _v in rectPoints do
						if _callback_1(_v, _k - 1, rectPoints) then
							_result_1 = true
							break
						end
					end
					-- ▲ ReadonlyArray.some ▲
					return _result_1
				end
				for _k, _v in expectedPoints do
					if not _callback(_v, _k - 1, expectedPoints) then
						_result = false
						break
					end
				end
				-- ▲ ReadonlyArray.every ▲
				local pointsMatch = _result
				expect(pointsMatch).to.equal(true)
			end)
		end)
	end)
end
