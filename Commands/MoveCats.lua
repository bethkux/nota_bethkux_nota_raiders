function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Move custom group to defined position. Group is defined by table of unitID => formationIndex.",
		parameterDefs = {
			{ 
				name = "Kittens",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},			
			{ 
				name = "Kitten_Positions", -- positions of kittens in the line
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "meow!",
			},
			{ 
				name = "fight",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "false",
			}
		}
	}
end

-- constants
local THRESHOLD_STEP = 25
local THRESHOLD_DEFAULT = 0

-- speed-ups
local SpringGetUnitPosition = Spring.GetUnitPosition
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit

local function ClearState(self)
	self.threshold = THRESHOLD_DEFAULT
	self.lastPointmanPosition = Vec3(0,0,0)
end

function Run(self, units, parameter)
	local kittens = parameter.Kittens
	local kittenPositions = parameter.Kitten_Positions -- Vec3
	local fight = parameter.fight -- boolean

	-- pick the spring command implementing the move
	local cmdID = CMD.MOVE
	if (fight) then cmdID = CMD.FIGHT end

	for posIndex, unitID in pairs(kittens) do
		if true then
			local thisUnitWantedPosition = kittenPositions[posIndex]
			Spring.Echo("[MoveCats] position for posIndex=" .. tostring(posIndex) .. " unitID=" .. tostring(unitID))
			if not thisUnitWantedPosition then
				Spring.Echo("[MoveCats] nil position for posIndex=" .. tostring(posIndex) .. " unitID=" .. tostring(unitID))
			else
				SpringGiveOrderToUnit(unitID, cmdID, thisUnitWantedPosition:AsSpringVector(), {})
			end
		end
	end
		
	return RUNNING
	
end


function Reset(self)
	ClearState(self)
end
