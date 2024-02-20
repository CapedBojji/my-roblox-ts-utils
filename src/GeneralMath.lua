-- Compiled with roblox-ts v2.3.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Point2D = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Point").default
local function getXWhereTwoLinesIntersectGivenSlopeAndYIntercept(m1, b1, m2, b2)
	return (b2 - b1) / (m1 - m2)
end
local function findYGivenXAndSlopeIntercept(x, m, b)
	return m * x + b
end
local function findXGivenYAndSlopeIntercept(y, m, b)
	return (y - b) / m
end
local function centroid(points)
	local x = 0
	local y = 0
	-- ▼ ReadonlyArray.forEach ▼
	local _callback = function(p)
		x += p:getX()
		y += p:getY()
	end
	for _k, _v in points do
		_callback(_v, _k - 1, points)
	end
	-- ▲ ReadonlyArray.forEach ▲
	return Point2D.new(x / #points, y / #points)
end
local function angleOfLineBetweenTwoPoints(p1, p2)
	return math.atan2(p2:getY() - p1:getY(), p2:getX() - p1:getX())
end
local function distanceBetweenTwoPoints(p1, p2)
	return math.sqrt(math.pow(p2:getX() - p1:getX(), 2) + math.pow(p2:getY() - p1:getY(), 2))
end
local function rotatePoint(x, y, angle)
	local newX = x * math.cos(angle) - y * math.sin(angle)
	local newY = x * math.sin(angle) + y * math.cos(angle)
	return { newX, newY }
end
local GeneralMath = {
	getX_2MB = getXWhereTwoLinesIntersectGivenSlopeAndYIntercept,
	getY_XMB = findYGivenXAndSlopeIntercept,
	getX_YMB = findXGivenYAndSlopeIntercept,
	centroid = centroid,
	getAngle_2Points = angleOfLineBetweenTwoPoints,
	getDistance_2Points = distanceBetweenTwoPoints,
	rotatePoint = rotatePoint,
}
local default = GeneralMath
return {
	default = default,
}
