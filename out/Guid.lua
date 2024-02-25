-- Compiled with roblox-ts v2.3.0
local Guid
do
	Guid = setmetatable({}, {
		__tostring = function()
			return "Guid"
		end,
	})
	Guid.__index = Guid
	function Guid.new(...)
		local self = setmetatable({}, Guid)
		return self:constructor(...) or self
	end
	function Guid:constructor()
	end
	function Guid:newGuid(size)
		local guid
		repeat
			do
				guid = Guid:generateGuid(size)
			end
			local _generatedGuids = Guid.generatedGuids
			local _guid = guid
		until not (_generatedGuids[_guid] ~= nil)
		local _generatedGuids = Guid.generatedGuids
		local _guid = guid
		_generatedGuids[_guid] = true
		return guid
	end
	function Guid:generateGuid(size)
		local guid = ""
		local characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
		do
			local i = 0
			local _shouldIncrement = false
			while true do
				if _shouldIncrement then
					i += 1
				else
					_shouldIncrement = true
				end
				if not (i < size) then
					break
				end
				local _i = i
				local _arg1 = i + 1
				guid ..= string.sub(characters, _i, _arg1)
			end
		end
		return guid
	end
	Guid.generatedGuids = {}
end
return nil
