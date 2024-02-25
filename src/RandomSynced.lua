-- Compiled with roblox-ts v2.3.0
local RandomSynced
do
	RandomSynced = setmetatable({}, {
		__tostring = function()
			return "RandomSynced"
		end,
	})
	RandomSynced.__index = RandomSynced
	function RandomSynced.new(...)
		local self = setmetatable({}, RandomSynced)
		return self:constructor(...) or self
	end
	function RandomSynced:constructor(seed, min, max)
		if min == nil then
			min = 0
		end
		if max == nil then
			max = 1
		end
		self._seed = seed
		self._random = Random.new(seed)
		self._min = min
		self._max = max
		self._memo = {}
	end
	function RandomSynced:numberAt(index)
		local __memo = self._memo
		local _index = index
		if __memo[_index] ~= nil then
			local __memo_1 = self._memo
			local _index_1 = index
			return __memo_1[_index_1]
		end
		while true do
			-- ▼ ReadonlyMap.size ▼
			local _size = 0
			for _ in self._memo do
				_size += 1
			end
			-- ▲ ReadonlyMap.size ▲
			if not (_size < index) then
				break
			end
			local __memo_1 = self._memo
			-- ▼ ReadonlyMap.size ▼
			local _size_1 = 0
			for _ in self._memo do
				_size_1 += 1
			end
			-- ▲ ReadonlyMap.size ▲
			local _arg1 = self._random:NextNumber(self._min, self._max)
			__memo_1[_size_1] = _arg1
		end
		local __memo_1 = self._memo
		local _index_1 = index
		return __memo_1[_index_1]
	end
end
return nil
