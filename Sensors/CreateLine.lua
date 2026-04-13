local sensorInfo = {
	name = "CreateLine",
	desc = "Creates line",
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

return function(WindDataX, WindDataZ, Position, Spacing, Size)

    local normalVector = Vec3(0,0,0)
    normalVector["x"] = WindDataZ * (-1)
    normalVector["z"] = WindDataX
    local startOfLine = Position + normalVector * (Size / 2) * Spacing * (-1)
    local skip = 0
    local isEven = false
    if (Size % 2 == 0) then
    isEven = true
    end
    local cat = 0

    if (isEven) then
        cat = (Size / 2)
    else 
        cat = ((Size + 1) / 2)
    end
    local postionArray = {}
    for i=1, Size do
        if (i == cat) then
            skip = 1
        end
        postionArray[i] = Vec3(0,0,0)
    	postionArray[i] = startOfLine +   normalVector * Spacing * (i - 1 + skip)
        --postionArray[i]["x"] = startOfLine["x"] + (i - 1 + skip) * normalVector * Spacing
    end

    return postionArray
end