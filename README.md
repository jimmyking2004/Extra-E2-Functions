# Extra-E2-Functions

EEF converts most of the useful LUA functions into E2 functions.

# Main Functions
- E:getGroundEntity() - Gets the entity that a player/NPC is standing on.
- E:isMapMade() - Is the entity created by the map?
- E:timeCreated() - Gets the time that the entity was created in relation server start.
- E:hasBoneManipulations() - Can the entities bones be manipulated?
- E:isRagdoll() - Is the entity a ragdoll?
- E:mapCreationID() - Gets the map creation ID of an entity, this ID wont change unless the map is edited. Returns -1 if the entity is not created by the map.
- E:removeDecals() - Removes all decals from the entity. (Crowbars are no longer a nuisance!)
- E:isPersistent() - Is the entity persistent?
- E:waterLevel() - How deep is the entity in the water? 0 - Not in water. | 1 - Touching in water. | 2 - Half in water. | 3 - Fully under water.
- E:canUseFlashlight() - Can the player use their flashlight?
- E:getHands() - Gets the players hands.
- E:canColideWithTeam() - Can the player collide with team mates?
- E:getRagdoll() - Gets the players death ragdoll.
- E:getWeapons() - Gets a list of weapons this player has.
- E:isBot() - Is the player a bot?
- E:isConnected() - Is the player (entity) connected to the server?.
- E:isAuth() - Is the player authenticated with steam network?
- E:isHostPlayer() - Is this player hosting the local server? (Not the same as server owner.)
- E:steamID64() - Gets the 64 bit version of the players steam ID
- E:stress() - Gets the physical stress being applied on the entity.
- E:getAnimID() - Gets the current animation ID of the entity.
- E:getAnimList() - Gets the entities list of animations as strings.
- E:held() - Returns the last entity the player attempted to physgun.
- E:inGod() - Is the player in god mode?
- E:setUnbreakable(N) - Set if the entity can be broken by physics.
- E:keepUpright(N, N) - Apply keep upright to the entity. Args: (BoneID, Strength)

- killOwner() - Kills the owner of the E2.
- freezeOwner(N) - Freezes the owner preventing control, removing the initial E2 that froze you will automatically unfreeze you if you get stuck.

# Deprecated
- E:inGod() - Functions exactly the same as inGodMode(), so it should be used instead if possible.
- E:getWeapons() - Functions exactly the same as weapons(), so it should be used instead if possible.
- E:timeCreated() - Functions exactly the same as creationTime(), so it should be used instead if possible.
- E:setVel() - Close if not the same as Propcore propSetVelocity(), so it should be used instead if possible.
- E:setInstVel() - Close if not the same as Propcore propSetVelocityInstant(), so it should be used instead if possible.
