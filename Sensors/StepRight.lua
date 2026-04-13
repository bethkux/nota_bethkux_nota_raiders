local sensorInfo = {
	name = "StepRight",
	desc = "Sends data",
	author = "Kulichova",
	date = "2026-04-13",
	license = "MIT",
}

-- get madatory module operators
VFS.Include("modules.lua") -- modules table
VFS.Include(modules.attach.data.path .. modules.attach.data.head) -- attach lib module

-- get other madatory dependencies
attach.Module(modules, "message") -- communication backend load

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- @description return current wind statistics
return function(Position)
	local myPosition = Position 
	local returnPosition = Vec3(0,0,0) 
	returnPosition["x"] = myPosition["x"] + 200
	returnPosition["z"] = myPosition["z"] + 200
	return returnPosition
end