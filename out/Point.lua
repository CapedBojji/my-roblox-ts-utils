-- Compiled with roblox-ts v2.3.0
local Point2D
do
	Point2D = setmetatable({}, {
		__tostring = function()
			return "Point2D"
		end,
	})
	Point2D.__index = Point2D
	function Point2D.new(...)
		local self = setmetatable({}, Point2D)
		return self:constructor(...) or self
	end
	function Point2D:constructor(x, y)
		self.point = Vector2.new(x, y)
		self.X = x
		self.Y = y
	end
	function Point2D:equals(point)
		return self.point.X == point.point.X and self.point.Y == point.point.Y
	end
	function Point2D:getX()
		return self.point.X
	end
	function Point2D:getY()
		return self.point.Y
	end
end
local default = Point2D
return {
	default = default,
}
