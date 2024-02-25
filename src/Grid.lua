-- Compiled with roblox-ts v2.3.0
local Direction = {
	UP = "UP",
	DOWN = "DOWN",
	LEFT = "LEFT",
	RIGHT = "RIGHT",
}
local CellFactory
do
	CellFactory = setmetatable({}, {
		__tostring = function()
			return "CellFactory"
		end,
	})
	CellFactory.__index = CellFactory
	function CellFactory.new(...)
		local self = setmetatable({}, CellFactory)
		return self:constructor(...) or self
	end
	function CellFactory:constructor()
	end
	function CellFactory:createCell(x, y, value)
		return {
			getValue = function()
				return value
			end,
			getX = function()
				return x
			end,
			getY = function()
				return y
			end,
		}
	end
end
local Grid
do
	Grid = setmetatable({}, {
		__tostring = function()
			return "Grid"
		end,
	})
	Grid.__index = Grid
	function Grid.new(...)
		local self = setmetatable({}, Grid)
		return self:constructor(...) or self
	end
	function Grid:constructor(width, height, initialValue)
		self._grid = table.create(height)
		local _exp = self._grid
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(_, y)
			self._grid[y + 1] = table.create(width)
			local _exp_1 = self._grid[y + 1]
			-- ▼ ReadonlyArray.forEach ▼
			local _callback_1 = function(_, x)
				self._grid[y + 1][x + 1] = CellFactory:createCell(x, y, initialValue)
			end
			for _k, _v in _exp_1 do
				_callback_1(_v, _k - 1, _exp_1)
			end
			-- ▲ ReadonlyArray.forEach ▲
		end
		for _k, _v in _exp do
			_callback(_v, _k - 1, _exp)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function Grid:getCell(x, y)
		return self._grid[y + 1][x + 1]
	end
	function Grid:setCell(x, y, value)
		self._grid[y + 1][x + 1] = CellFactory:createCell(x, y, value)
	end
	function Grid:getWidth()
		return #self._grid[1]
	end
	function Grid:getHeight()
		return #self._grid
	end
	function Grid:getNextCell(x, y, direction)
		repeat
			if direction == "UP" then
				return self:getCell(x, y - 1)
			end
			if direction == "DOWN" then
				return self:getCell(x, y + 1)
			end
			if direction == "LEFT" then
				return self:getCell(x - 1, y)
			end
			return self:getCell(x + 1, y)
		until true
	end
end
local default = Grid
return {
	default = default,
}
