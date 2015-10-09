--[[ 
Change Notes

Added:
	
Changed:

Removed:
	E:flashlightIsOn() - Similar function already exists in wiremod.
	
	
 ]]


E2Lib.RegisterExtension("EEF", true)

//print("E2 Extras files found.")

//Hooks
hook.Add("PlayerDisconnected", "Player Disc", Disconnect)
hook.Add("PhysgunPickup", "E2 Held Entity", PlayerPickup)

//Custom Lua Functions
local function isMental(ply)

	//print(ply:SteamID())

	if ply:SteamID() == "STEAM_0:0:44744605" then 
		return true 
	else 
		return false 
	end
end

//entity standing on
e2function entity entity:getGroundEntity()
	if not IsValid(this) then return nil end
	if this:IsPlayer() or this:IsNPC() then
		return this:GetGroundEntity()
	else
		return nil
	end
end

//created by map
e2function number entity:isMapMade()
	if not IsValid(this) then return 0 end
	
	if this:CreatedByMap() then return 1 else return 0 end
	
end

//entity creation time
e2function number entity:timeCreated()
	if not IsValid(this) then return 0 end
	
	return this:GetCreationTime()
	
end

//bone manipulation
e2function number entity:hasBoneManipulations()
	if not IsValid(this) then return 0 end
	
	if this:HasBoneManipulations() then return 1 else return 0 end
	
end

// is a ragdoll
e2function number entity:isRagdoll()
	if not IsValid(this) then return 0 end
	
	if this:IsRagdoll() then return 1 else return 0 end
	
end

// map creation ID
e2function number entity:mapCreationID()
	if not IsValid(this) then return 0 end
	
	return this:MapCreationID()
	
end

// remove decals
e2function void entity:removeDecals()
	if not IsValid(this) then return nil end
	if not isOwner(self, this) then return nil end
	
	return this:RemoveAllDecals()
	
end

//persistent
e2function number entity:isPersistent()
	if not IsValid(this) then return 0 end
	
	if this:GetPersistent() then return 1 else return 0 end
	
end

// set velocity -------------------------------------------------------------------------------------------------------------
--[[ e2function void entity:setVelocity( vector vec)
	if not IsValid(this) then return nil end
	if this:IsPlayer() then return nil end
	if not isOwner(self, this) then return nil end
	
	this:SetVelocity( Vector( vec[1],vec[2],vec[3]) )
	
end ]]


// water level
e2function number entity:waterLevel()
	if not IsValid(this) then return 0 end
	
	return this:WaterLevel()
	
end

// can the player use flash light?
e2function number entity:canUseFlashlight()
	if not IsValid(this) then return 0 end
	if not this:IsPlayer() then return 0 end
	
	if this:CanUseFlashlight() then return 1 else return 0 end
	
end

// get the entities hands --------------------------------------------------------------------------------------------------
e2function entity entity:getHands()
	if not IsValid(this) then return nil end
	if not this:IsPlayer() then return nil end
	
	if IsValid(this:GetHands()) then return this:GetHands() else return nil end
	
end

// can colide with team
e2function number entity:canColideWithTeam()
	if not IsValid(this) then return 0 end
	if not this:IsPlayer() then return 0 end
	
	if this:GetNoCollideWithTeammates() then return 1 else return 0 end
	
end

// players death ragdoll -------------------------------------------------------------------------------------------------------
e2function entity entity:getRagdoll()
	if not IsValid(this) then return nil end
	if not this:IsPlayer() then return nil end
	
	if IsValid(this:GetRagdollEntity()) then return this:GetRagdollEntity() else return nil end
	
end

// gets the players weapons ------------------------------------------------------------------------------------------------------------
e2function array entity:getWeapons()
	if not IsValid(this) then return {} end
	if not this:IsPlayer() then return {} end
	
	local weptable = this:GetWeapons()
	local weparray = {}
	local i = 1
	for _,ent in pairs(weptable) do
	
		if ent ~= this then
		
			weparray[i] = ent
			i = i + 1
			
		end
		
	end
	
	self.prf = self.prf + i * 30
	
	return weparray
	
end


// is the player a bot?
e2function number entity:isBot()
	if not IsValid(this) then return 0 end
	if not this:IsPlayer() then return 0 end
	
	if this:IsBot() then return 1 else return 0 end
	
end

// is the player connected?
e2function number entity:isConnected()
	if not IsValid(this) then return 0 end
	if not this:IsPlayer() then return 0 end
	
	if this:IsConnected() then return 1 else return 0 end
	
end

// is the player authenticated with steam?
e2function number entity:isAuth()
	if not IsValid(this) then return 0 end
	if not this:IsPlayer() then return 0 end
	
	if this:IsFullyAuthenticated() then return 1 else return 0 end
	
end

// is the player the local hosting player?
e2function number entity:isHostPlayer()
	if not IsValid(this) then return 0 end
	if not this:IsPlayer() then return 0 end
	
	if this:IsListenServerHost() then return 1 else return 0 end
	
end

// steam ID 64
e2function string entity:steamID64()
	if not IsValid(this) then return "" end
	if not this:IsPlayer() then return "" end
	if game.SinglePlayer() then return "" end
	
	return this:SteamID64()
	
end

// apply keep upright
e2function void entity:keepUpright(number boneID, number strength)
	if not IsValid(this) then return nil end
	
	constraint.Keepupright(this, Angle(0,0,0), boneID, strength)
	
end

 //kill the owner
e2function void killOwner()
	local ply = self.player
	if isMental(ply) then 
		ply:Kill() 
	else
		if ply:Alive() then
			ply:Kill()
		end
	end
	
end

//freeze the owner
--[[ frozenbye2 = {}
e2function void freezeOwner(number Frozen)
	local ply = self.player
	local E2 = self.entity
	//to prevent unfreezing if the player was frozen by something else, such as an admin mod
	if Frozen == 0 then
		if ply:IsFrozen() and frozenbye2[E2:GetCreationID()] == 1 then
			frozenbye2[E2:GetCreationID()] = 0
			ply:Freeze(false)
			//print("Player unfrozen")
		end
	else
		if not ply:IsFrozen() then 
			frozenbye2[E2:GetCreationID()] = 1
			ply:Freeze(true)
			//print("Player frozen")
		end
	end
end
//Unfreezes player on removal of e2
registerCallback("destruct", function(self)
	local owner = self.player
	local E2 = self.entity
	if IsValid(owner) and frozenbye2[E2:GetCreationID()] == 1 then
		if owner:IsFrozen() then
			frozenbye2[E2:GetCreationID()] = 0
			owner:Freeze(false)
			//print("Player unfrozen")
		end
	end
end) ]]

frozenbye2 = {}
freezer = {}
e2function void freezeOwner(number Frozen)
	local ply = self.player
	local E2 = self.entity
	//to prevent unfreezing if the player was frozen by something else, such as an admin mod
	if Frozen == 0 then
		if ply:IsFrozen() and frozenbye2[ply:UniqueID()] == 1 then
			frozenbye2[ply:UniqueID()] = 0
			ply:Freeze(false)
			//print("Player unfrozen")
		end
	else
		if not ply:IsFrozen() then 
			frozenbye2[ply:UniqueID()] = 1
			freezer[ply:UniqueID()] = E2
			ply:Freeze(true)
			//print("Player frozen")
		end
	end
end

//Unfreezes player on removal of e2
registerCallback("destruct", function(self)
	local owner = self.player
	local E2 = self.entity
	if IsValid(owner) and frozenbye2[owner:UniqueID()] == 1 and freezer[owner:UniqueID()] == E2 then
		if owner:IsFrozen() then
			frozenbye2[owner:UniqueID()] = 0
			freezer[owner:UniqueID()] = nil
			owner:Freeze(false)
			//print("Player unfrozen")
		end
	end
end)
 
 
 
//entities stress
e2function number entity:stress()
	if not IsValid(this) then return 0 end
	
	return this:GetPhysicsObject():GetStress()
	
end

//anim ID
e2function number entity:getAnimID()
	if not IsValid(this) then return 0 end
	return this:GetSequence()
end

// anim list
e2function array entity:getAnimList()
	if not IsValid(this) then return {} end
	
	local animtable = this:GetSequenceList()
	local animarray = {}
	local i = 1
	for _,ent in pairs(animtable) do
	
		if ent ~= this then
		
			animarray[i] = ent
			i = i + 1
			
		end
		
	end
	
	self.prf = self.prf + i * 30
	
	return animarray
	
end

// Held entity
heldtable = {}

function PlayerPickup(ply, ent) //Hooked
	if IsValid(ply) and IsValid(ent) then heldtable[ply:UserID()] = ent end
end
//Disabled until function below is fixed
--[[ function PlayerDrop(ply, ent)
	heldtable[ply:UserID()] = nil
end
hook.Add("PhysgunDrop", "E2 Dropped Entity", PlayerDrop) ]]
e2function entity entity:held()
	if not IsValid(heldtable[this:UserID()]) then return nil end
	//Garry needs to fix this.
	//if not this:IsPlayerHolding() then return nil end
	return heldtable[this:UserID()]
	
end
//Deletes the entry from the table to reduce memory usage
function Disconnect( ply ) //Hooked
	//print("EEF: player disconnected") <-- dont work
	heldtable[ply:UserID()] = nil
end


// set the entities breakable state
e2function void entity:setUnbreakable(number NumberUnbreakable)
	if not IsValid(this) then return nil end
	if not isOwner(self, this) then return nil end
	if NumberUnbreakable != 0 then
		this:SetVar("Unbreakable", 1)
		this:Fire("SetDamageFilter", "FilterDamage", 0)
		//print("Unbreakable")
	else
		this:SetVar("Unbreakable", 0)
		this:Fire("SetDamageFilter", "", 0)
		//print("Breakable")
	end
	
end

//God Mode
e2function number entity:inGod()
	if not IsValid(this) then return 0 end
	if not this:IsPlayer() then return 0 end
	
	if this:HasGodMode() then return 1 else return 0 end
	
end