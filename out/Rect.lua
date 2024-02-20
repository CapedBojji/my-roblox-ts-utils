-- Compiled with roblox-ts v2.3.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Point2D = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Point").default
local Segment = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Segment").default
local GeneralMath = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "GeneralMath").default
local GRect
do
	GRect = setmetatable({}, {
		__tostring = function()
			return "GRect"
		end,
	})
	GRect.__index = GRect
	function GRect.new(...)
		local self = setmetatable({}, GRect)
		return self:constructor(...) or self
	end
	function GRect:constructor(p1, p2, p3, p4)
		self.p1 = p1
		self.p2 = p2
		self.p3 = p3
		self.p4 = p4
	end
	function GRect:createRectFromPoints(p1, p2, p3, p4)
		local centroidPoint = GeneralMath.centroid({ p1, p2, p3, p4 })
		local points = { p1, p2, p3, p4 }
		table.sort(points, function(a, b)
			return GeneralMath.getAngle_2Points(a, centroidPoint) > GeneralMath.getAngle_2Points(b, centroidPoint)
		end)
		return GRect.new(points[1], points[2], points[3], points[4])
	end
	function GRect:createRectFromPart(part)
		local size = part.Size
		local cframe = part.CFrame
		local _cFrame = CFrame.new(-size.X / 2, 0, -size.Z / 2)
		local p1 = cframe * _cFrame
		local _cFrame_1 = CFrame.new(size.X / 2, 0, -size.Z / 2)
		local p2 = cframe * _cFrame_1
		local _cFrame_2 = CFrame.new(size.X / 2, 0, size.Z / 2)
		local p3 = cframe * _cFrame_2
		local _cFrame_3 = CFrame.new(-size.X / 2, 0, size.Z / 2)
		local p4 = cframe * _cFrame_3
		return GRect:createRectFromPoints(Point2D.new(p1.Position.X, p1.Position.Z), Point2D.new(p2.Position.X, p2.Position.Z), Point2D.new(p3.Position.X, p3.Position.Z), Point2D.new(p4.Position.X, p4.Position.Z))
	end
	function GRect:getMaxPoint()
		local points = self:getPoints()
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#points)
		local _callback = function(p)
			return p:getX()
		end
		for _k, _v in points do
			_newValue[_k] = _callback(_v, _k - 1, points)
		end
		-- ▲ ReadonlyArray.map ▲
		local x = _newValue
		-- ▼ ReadonlyArray.map ▼
		local _newValue_1 = table.create(#points)
		local _callback_1 = function(p)
			return p:getY()
		end
		for _k, _v in points do
			_newValue_1[_k] = _callback_1(_v, _k - 1, points)
		end
		-- ▲ ReadonlyArray.map ▲
		local y = _newValue_1
		local maxX = math.max(unpack(x))
		local maxY = math.max(unpack(y))
		return Point2D.new(maxX, maxY)
	end
	function GRect:getMinPoint()
		local points = self:getPoints()
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#points)
		local _callback = function(p)
			return p:getX()
		end
		for _k, _v in points do
			_newValue[_k] = _callback(_v, _k - 1, points)
		end
		-- ▲ ReadonlyArray.map ▲
		local x = _newValue
		-- ▼ ReadonlyArray.map ▼
		local _newValue_1 = table.create(#points)
		local _callback_1 = function(p)
			return p:getY()
		end
		for _k, _v in points do
			_newValue_1[_k] = _callback_1(_v, _k - 1, points)
		end
		-- ▲ ReadonlyArray.map ▲
		local y = _newValue_1
		local minX = math.min(unpack(x))
		local minY = math.min(unpack(y))
		return Point2D.new(minX, minY)
	end
	function GRect:getSides()
		return { Segment.new(self.p1, self.p2), Segment.new(self.p2, self.p3), Segment.new(self.p3, self.p4), Segment.new(self.p4, self.p1) }
	end
	function GRect:getPoints()
		return { self.p1, self.p2, self.p3, self.p4 }
	end
	function GRect:getSize()
		local length = GeneralMath.getDistance_2Points(self.p1, self.p2)
		local width = GeneralMath.getDistance_2Points(self.p2, self.p3)
		return Point2D.new(length, width)
	end
	function GRect:getArea()
		local size = self:getSize()
		return size:getX() * size:getY()
	end
	function GRect:getPerimeter()
		local size = self:getSize()
		return 2 * (size:getX() + size:getY())
	end
	function GRect:getRotation()
		local points = self:getPoints()
		local dy = points[2]:getY() - points[1]:getY()
		local dx = points[2]:getX() - points[1]:getX()
		local angle = math.atan2(dy, dx)
		return angle
	end
	function GRect:getAxisAlignedRect()
		local size = self:getSize()
		return GRect:createRectFromPoints(Point2D.new(size:getX() / 2, size:getY() / 2), Point2D.new(-size:getX() / 2, size:getY() / 2), Point2D.new(-size:getX() / 2, -size:getY() / 2), Point2D.new(size:getX() / 2, -size:getY() / 2))
	end
	function GRect:getBoundingBox()
		local points = self:getPoints()
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#points)
		local _callback = function(p)
			return p:getX()
		end
		for _k, _v in points do
			_newValue[_k] = _callback(_v, _k - 1, points)
		end
		-- ▲ ReadonlyArray.map ▲
		local x = _newValue
		-- ▼ ReadonlyArray.map ▼
		local _newValue_1 = table.create(#points)
		local _callback_1 = function(p)
			return p:getY()
		end
		for _k, _v in points do
			_newValue_1[_k] = _callback_1(_v, _k - 1, points)
		end
		-- ▲ ReadonlyArray.map ▲
		local y = _newValue_1
		local minX = math.min(unpack(x))
		local maxX = math.max(unpack(x))
		local minY = math.min(unpack(y))
		local maxY = math.max(unpack(y))
		return GRect.new(Point2D.new(minX, minY), Point2D.new(maxX, minY), Point2D.new(maxX, maxY), Point2D.new(minX, maxY))
	end
	function GRect:isPointInside(point)
		local _binding = GeneralMath.rotatePoint(point:getX(), point:getY(), -self:getRotation())
		local x = _binding[1]
		local y = _binding[2]
		local rotatedPoint = Point2D.new(x, y)
		local axisAlignedRect = self:getAxisAlignedRect()
		local points = axisAlignedRect:getPoints()
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#points)
		local _callback = function(p)
			return p:getX()
		end
		for _k, _v in points do
			_newValue[_k] = _callback(_v, _k - 1, points)
		end
		-- ▲ ReadonlyArray.map ▲
		local xValues = _newValue
		-- ▼ ReadonlyArray.map ▼
		local _newValue_1 = table.create(#points)
		local _callback_1 = function(p)
			return p:getY()
		end
		for _k, _v in points do
			_newValue_1[_k] = _callback_1(_v, _k - 1, points)
		end
		-- ▲ ReadonlyArray.map ▲
		local yValues = _newValue_1
		local minX = math.min(unpack(xValues))
		local maxX = math.max(unpack(xValues))
		local minY = math.min(unpack(yValues))
		local maxY = math.max(unpack(yValues))
		return rotatedPoint:getX() >= minX and rotatedPoint:getX() <= maxX and rotatedPoint:getY() >= minY and rotatedPoint:getY() <= maxY
	end
	function GRect:getCenter()
		return GeneralMath.centroid(self:getPoints())
	end
	function GRect:intersects(segment)
		local _exp = self:getSides()
		-- ▼ ReadonlyArray.some ▼
		local _result = false
		local _callback = function(side)
			return side:intersects(segment)
		end
		for _k, _v in _exp do
			if _callback(_v, _k - 1, _exp) then
				_result = true
				break
			end
		end
		-- ▲ ReadonlyArray.some ▲
		return _result
	end
	function GRect:intersectsRect(rect)
		local _exp = self:getSides()
		-- ▼ ReadonlyArray.some ▼
		local _result = false
		local _callback = function(side)
			return rect:intersects(side)
		end
		for _k, _v in _exp do
			if _callback(_v, _k - 1, _exp) then
				_result = true
				break
			end
		end
		-- ▲ ReadonlyArray.some ▲
		return _result
	end
	function GRect:getIntersection(segment)
		-- Loop through each side of the rectangle and check for intersection
		local _exp = self:getSides()
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#_exp)
		local _callback = function(side)
			return side:getIntersection(segment)
		end
		for _k, _v in _exp do
			_newValue[_k] = _callback(_v, _k - 1, _exp)
		end
		-- ▲ ReadonlyArray.map ▲
		local intersections = _newValue
		local nonUndefinedIntersections = {}
		for _, intersection in intersections do
			if intersection ~= nil then
				table.insert(nonUndefinedIntersections, intersection)
			end
		end
		-- If the segment intersects, and the intersection is a segment, return the segment
		-- ▼ ReadonlyArray.filter ▼
		local _newValue_1 = {}
		local _callback_1 = function(intersection)
			return TS.instanceof(intersection, Segment)
		end
		local _length = 0
		for _k, _v in nonUndefinedIntersections do
			if _callback_1(_v, _k - 1, nonUndefinedIntersections) == true then
				_length += 1
				_newValue_1[_length] = _v
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		local segmentIntersections = _newValue_1
		if #segmentIntersections > 0 then
			return segmentIntersections[1]
		end
		-- If the segment intersects, and the intersection is a point at the end of the segment, return the point
		-- ▼ ReadonlyArray.filter ▼
		local _newValue_2 = {}
		local _callback_2 = function(intersection)
			return TS.instanceof(intersection, Point2D)
		end
		local _length_1 = 0
		for _k, _v in nonUndefinedIntersections do
			if _callback_2(_v, _k - 1, nonUndefinedIntersections) == true then
				_length_1 += 1
				_newValue_2[_length_1] = _v
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		local pointIntersections = _newValue_2
		-- If no intersections are found, return undefined
		-- Because if there are no segment intersections, there will always be at least one point intersection
		if #pointIntersections == 0 then
			return nil
		end
		-- If the point intersections is only one, return the point
		if #pointIntersections == 1 then
			return pointIntersections[1]
		end
		local _exp_1 = self:getPoints()
		-- ▼ ReadonlyArray.find ▼
		local _callback_3 = function(point)
			-- ▼ ReadonlyArray.some ▼
			local _result = false
			local _callback_4 = function(intersection)
				if point:equals(intersection) then
					return true
				end
			end
			for _k, _v in pointIntersections do
				if _callback_4(_v, _k - 1, pointIntersections) then
					_result = true
					break
				end
			end
			-- ▲ ReadonlyArray.some ▲
			return _result
		end
		local _result
		for _i, _v in _exp_1 do
			if _callback_3(_v, _i - 1, _exp_1) == true then
				_result = _v
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		local intersectionAtRectCorner = _result
		if intersectionAtRectCorner ~= nil then
			return intersectionAtRectCorner
		end
		-- Else, find the next intersection, and return a segment from the first intersection to the next intersection
		local firstIntersection = pointIntersections[1]
		local secondIntersection = pointIntersections[2]
		return Segment.new(firstIntersection, secondIntersection)
	end
end
local default = GRect
return {
	default = default,
}
