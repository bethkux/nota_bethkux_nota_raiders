local sensorInfo = {
	name = "CatDebug",
	desc = "Sends data to widget",
	author = "Kulichova",
	date = "2018-04-16",
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
return function(Wx, Wy, Wz, Cat, Spacing)
	
	local ID = 0

	local cx = 0
	local cy = 0
	local cz = 0 
	if #Cat > 0 then
		cx,cy,cz = Spring.GetUnitPosition(Cat[1])
		if (Script.LuaUI('PURRFECTWIDGET')) then
			Script.LuaUI.PURRFECTWIDGET(
				ID, -- keyS
				{	-- data
					startPos = Vec3(cx, cy, cz), 
					endPos = Vec3(cx, cy, cz) + Vec3(Wx * 100, 0, Wz * 100)
				}
			)
			ID = ID+1
			
            Script.LuaUI.PURRFECTWIDGET(
				ID, -- keyS
				{	-- data
					startPos = Vec3(cx, cy, cz), 
					endPos = Vec3(cx, cy, cz) + Vec3(-Wx * 50, 0, -Wz * 50)
				}
			)
			ID = ID+1
		end
	else
	return

	end

	if #units > 0 then
		local kitten1 = units[1] --kittens
		local kittenN = units[#units]
		local nkittens = #units
        local len = Spacing / 2
        local plus = 10

		local x,y,z = Spring.GetUnitPosition(kitten1)
		if (Script.LuaUI('PURRFECTWIDGET')) then
			Script.LuaUI.PURRFECTWIDGET(
				ID, -- keyS
				{	-- data
					startPos = Vec3(cx, cy, cz), 
					endPos = Vec3(cx, cy, cz) + Vec3(-Wz * len * nkittens - Wz * plus , 0, Wx * len * nkittens + Wx * plus)
				}
			)
			ID = ID+1

			Script.LuaUI.PURRFECTWIDGET(
				ID, -- key
				{	-- data
					startPos = Vec3(cx, cy, cz), 
					endPos = Vec3(cx, cy, cz) + Vec3(Wz * len * nkittens + Wz * plus, 0, -Wx * len * nkittens - Wx * plus)
					
				}
			)
			ID = ID+1
		end

        if (Script.LuaUI('PURRFECTANGLE')) then
			Script.LuaUI.PURRFECTANGLE(
				ID, -- keyS
				{	-- data
                    angle = 180 + math.deg(math.atan2(Wx, Wz)),
					startPos = Vec3(cx, cy, cz), 
				}
			)
            ID = ID+1
        end

		return {	-- data
					startPos = Vec3(x,y,z), 
					endPos = Vec3(x,y,z) + Vec3(100, 0, 100)
				}
	end
end