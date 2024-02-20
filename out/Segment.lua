-- Compiled with roblox-ts v2.3.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Point2D = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Point").default
local GeneralMath = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "GeneralMath").default
local Segment
do
	Segment = setmetatable({}, {
		__tostring = function()
			return "Segment"
		end,
	})
	Segment.__index = Segment
	function Segment.new(...)
		local self = setmetatable({}, Segment)
		return self:constructor(...) or self
	end
	function Segment:constructor(p1, p2)
		self.p1 = p1
		self.p2 = p2
	end
	function Segment:getPoints()
		return { self.p1, self.p2 }
	end
	function Segment:getSlope()
		if self.p1 == self.p2 then
			return nil
		end
		if self.p1:getX() == self.p2:getX() then
			return nil
		end
		if self.p1:getY() == self.p2:getY() then
			return 0
		end
		return (self.p2:getY() - self.p1:getY()) / (self.p2:getX() - self.p1:getX())
	end
	function Segment:getLength()
		return math.sqrt(math.pow(self.p2:getX() - self.p1:getX(), 2) + math.pow(self.p2:getY() - self.p1:getY(), 2))
	end
	function Segment:isVertical()
		return self.p1:getX() == self.p2:getX()
	end
	function Segment:isHorizontal()
		return self.p1:getY() == self.p2:getY()
	end
	function Segment:isParallelTo(segment)
		return self:getSlope() == segment:getSlope()
	end
	function Segment:isPerpendicularTo(segment)
		if self:isVertical() and segment:isHorizontal() then
			return true
		end
		if self:isHorizontal() and segment:isVertical() then
			return true
		end
		return self:getSlope() == -1 / (segment:getSlope())
	end
	function Segment:xIntercept()
		if self:isHorizontal() then
			return nil
		end
		if self:isVertical() then
			return self.p1:getX()
		end
		return -(self:yIntercept()) / (self:getSlope())
	end
	function Segment:yIntercept()
		if self:isVertical() then
			return nil
		end
		if self:isHorizontal() then
			return self.p1:getY()
		end
		return self.p1:getY() - (self:getSlope()) * self.p1:getX()
	end
	function Segment:equals(segment)
		if self.p1:equals(segment.p1) and self.p2:equals(segment.p2) then
			return true
		end
		return self.p1:equals(segment.p2) and self.p2:equals(segment.p1)
	end
	function Segment:isCollinearWith(segment)
		if not self:isParallelTo(segment) then
			return false
		end
		if self:isVertical() then
			return self.p1:getX() == segment.p1:getX()
		end
		if self:isHorizontal() then
			return self.p1:getY() == segment.p1:getY()
		end
		return self:yIntercept() == segment:yIntercept()
	end
	function Segment:containsPoint(point)
		if self:isVertical() then
			if point:getX() ~= self.p1:getX() then
				return false
			end
			return (point:getY() >= self.p1:getY() and point:getY() <= self.p2:getY()) or (point:getY() <= self.p1:getY() and point:getY() >= self.p2:getY())
		end
		if self:isHorizontal() then
			if point:getY() ~= self.p1:getY() then
				return false
			end
			return (point:getX() >= self.p1:getX() and point:getX() <= self.p2:getX()) or (point:getX() <= self.p1:getX() and point:getX() >= self.p2:getX())
		end
		return point:getY() == (self:getSlope()) * point:getX() + (self:yIntercept()) and point:getX() >= math.min(self.p1:getX(), self.p2:getX()) and point:getX() <= math.max(self.p1:getX(), self.p2:getX())
	end
	function Segment:intersects(segment)
		if self:isParallelTo(segment) and not self:isCollinearWith(segment) then
			return false
		end
		if self:isCollinearWith(segment) then
			if self:containsPoint(segment.p1) then
				return true
			end
			if self:containsPoint(segment.p2) then
				return true
			end
			if segment:containsPoint(self.p1) then
				return true
			end
			if segment:containsPoint(self.p2) then
				return true
			end
			return false
		end
		if self:isPerpendicularTo(segment) then
			-- isPerpendicularTo only checks if the slopes are negative reciprocals
			-- so we need to check if they intersect
			if self:isVertical() then
				local minX, maxX = math.min(segment.p1:getX(), segment.p2:getX()), math.max(segment.p1:getX(), segment.p2:getX())
				local minY, maxY = math.min(self.p1:getY(), self.p2:getY()), math.max(self.p1:getY(), self.p2:getY())
				return self.p1:getX() >= minX and self.p1:getX() <= maxX and segment.p1:getY() >= minY and segment.p1:getY() <= maxY
			end
			if segment:isVertical() then
				local minX, maxX = math.min(self.p1:getX(), self.p2:getX()), math.max(self.p1:getX(), self.p2:getX())
				local minY, maxY = math.min(segment.p1:getY(), segment.p2:getY()), math.max(segment.p1:getY(), segment.p2:getY())
				return segment.p1:getX() >= minX and segment.p1:getX() <= maxX and self.p1:getY() >= minY and self.p1:getY() <= maxY
			end
			local m1 = self:getSlope()
			local m2 = segment:getSlope()
			local b1 = self:yIntercept()
			local b2 = segment:yIntercept()
			local x = GeneralMath.getX_2MB(m1, b1, m2, b2)
			local y = m1 * x + b1
			return self:containsPoint(Point2D.new(x, y)) and segment:containsPoint(Point2D.new(x, y))
		end
		-- Case where one segment is vertical and the other is not
		if self:isVertical() then
			local m = segment:getSlope()
			local b = segment:yIntercept()
			local x = self.p1:getX()
			local y = GeneralMath.getY_XMB(x, m, b)
			return self:containsPoint(Point2D.new(x, y)) and segment:containsPoint(Point2D.new(x, y))
		end
		if segment:isVertical() then
			local m = self:getSlope()
			local b = self:yIntercept()
			local x = segment.p1:getX()
			local y = GeneralMath.getY_XMB(x, m, b)
			return self:containsPoint(Point2D.new(x, y)) and segment:containsPoint(Point2D.new(x, y))
		end
		-- Case where one segment is horizontal and the other is not
		if self:isHorizontal() then
			local m = segment:getSlope()
			local b = segment:yIntercept()
			local y = self.p1:getY()
			local x = GeneralMath.getX_YMB(y, m, b)
			return self:containsPoint(Point2D.new(x, y)) and segment:containsPoint(Point2D.new(x, y))
		end
		if segment:isHorizontal() then
			local m = self:getSlope()
			local b = self:yIntercept()
			local y = segment.p1:getY()
			local x = GeneralMath.getX_YMB(y, m, b)
			return self:containsPoint(Point2D.new(x, y)) and segment:containsPoint(Point2D.new(x, y))
		end
		-- All edge cases have been handled, so we can assume that both segments are neither vertical nor horizontal
		local m1 = self:getSlope()
		local m2 = segment:getSlope()
		local b1 = self:yIntercept()
		local b2 = segment:yIntercept()
		local x = GeneralMath.getX_2MB(m1, b1, m2, b2)
		local y = m1 * x + b1
		return self:containsPoint(Point2D.new(x, y)) and segment:containsPoint(Point2D.new(x, y))
	end
	function Segment:getIntersection(segment)
		if not self:intersects(segment) then
			return nil
		end
		-- The segments are guaranteed to intersect
		if self:isCollinearWith(segment) then
			local p1, p2, p3, p4 = self.p1, self.p2, segment.p1, segment.p2
			-- If vertical, sort by Y
			if self:isVertical() then
				local _exp = { p1, p2, p3, p4 }
				table.sort(_exp, function(a, b)
					return a:getY() > b:getY()
				end)
				local points = _exp
				if points[2]:equals(points[3]) then
					return points[2]
				end
				return Segment.new(points[2], points[3])
			end
			-- Sort by X
			local _exp = { p1, p2, p3, p4 }
			table.sort(_exp, function(a, b)
				return a:getX() > b:getX()
			end)
			local points = _exp
			if points[2]:equals(points[3]) then
				return points[2]
			end
			return Segment.new(points[2], points[3])
		end
		if self:isPerpendicularTo(segment) then
			if self:isVertical() then
				return Point2D.new(self.p1:getX(), segment.p1:getY())
			end
			if segment:isVertical() then
				return Point2D.new(segment.p1:getX(), self.p1:getY())
			end
			-- Both segments are neither vertical nor horizontal
		end
		-- All edge cases have been handled, so we can assume that both segments are neither vertical nor horizontal
		local m1 = self:getSlope()
		local m2 = segment:getSlope()
		local b1 = self:yIntercept()
		local b2 = segment:yIntercept()
		local x = GeneralMath.getX_2MB(m1, b1, m2, b2)
		local y = m1 * x + b1
		return Point2D.new(x, y)
	end
end
local default = Segment
return {
	default = default,
}
