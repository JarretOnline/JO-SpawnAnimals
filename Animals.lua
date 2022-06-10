-- WE WERE HAVING ISSUES WITH HUNTING AND ONESYNC WHERE ANIMALS WERE NOT SPAWNING, CREATED THIS WITH THE HELP OF SOME OTHERS TO ENABLE ANIMAL SPAWNS IN CERTAIN LOCATIONS--
---YOU CAN COPY PASTE LINES 3 THROUGH 65 AND CHANGE ANIMAL MODELS TO SPAWN OTHER ANIMALS---

local entities = {} 
Citizen.CreateThread(function()			 

while true do
Wait(0)		

local player = GetPlayerPed(-1)
local pos = GetEntityCoords(player,1)
local ground
if (IsEntityInZone(player, "CMSW")--These are the zones animals spawn in, to find more zones search google for int GET_ZONE_FROM_NAME_ID
or IsEntityInZone(player, "MTCHIL")
or IsEntityInZone(player, "MTGORDO")
or IsEntityInZone(player, "MTJOSE")
or IsEntityInZone(player, "PALFOR")
or IsEntityInZone(player, "PALHIGH")
or IsEntityInZone(player, "SANCHIA")
or IsEntityInZone(player, "TONGVAH")
or IsEntityInZone(player, "PALHIGH"))
and #entities < 8 then--how many animals to spawn

RequestModel("a_c_deer") --model of animal, this is a deer
while not HasModelLoaded("a_c_deer") or not HasCollisionForModelLoaded("a_c_deer") do
Wait(1)
end		

RequestModel("a_c_mtlion") --model of animal, this is a mountain lion
while not HasModelLoaded("a_c_mtlion") or not HasCollisionForModelLoaded("a_c_mtlion") do
Wait(1)
end		

RequestModel("a_c_rabbit_01") --model of animal, this is a rabbit 
while not HasModelLoaded("a_c_rabbit_01") or not HasCollisionForModelLoaded("a_c_rabbit_01") do
Wait(1)
end	


posX = pos.x+math.random(-100,100)
posY = pos.y+math.random(-100,100)
Z = pos.z+999.0
heading = math.random(0,359)+.0

ground,posZ = GetGroundZFor_3dCoord(posX+.0,posY+.0,Z,1)

if(ground) then

ped = CreatePed(28, "a_c_deer", posX, posY, posZ, heading, true, true)
SetEntityAsMissionEntity(ped, true, true)
TaskWanderStandard(ped, 10.0, 10)
			SetModelAsNoLongerNeeded(ped)
			SetPedAsNoLongerNeeded(ped) -- despawn when player no longer in the area
			table.insert(entities,ped)

local blip = AddBlipForEntity(ped)
SetBlipSprite(blip,0) --animal blips (141) or  (0) for none
SetBlipColour(blip,80) -- transparent on map
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("spawned entity")
EndTextCommandSetBlipName(blip)       			   
end
end

 for i, ped in pairs(entities) do
     if IsEntityInWater(ped) then --if the animal spawns in water it will auto delete
	    local model = GetEntityModel(ped)
	    SetEntityAsNoLongerNeeded(ped)
		SetModelAsNoLongerNeeded(model)
	    DeleteEntity(ped)
	    table.remove(entities,i)	
	 end
 end
 ------------------------------------------
end
end)


