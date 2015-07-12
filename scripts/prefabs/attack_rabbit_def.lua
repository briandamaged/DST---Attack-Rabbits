local assets =
{
    Asset("ANIM", "anim/ds_rabbit_basic.zip"),
    Asset("ANIM", "anim/rabbit_build.zip"),
    Asset("ANIM", "anim/beard_monster.zip"),
    Asset("ANIM", "anim/rabbit_winter_build.zip"),
    Asset("SOUND", "sound/rabbit.fsb"),
}


-- local STRINGS = GLOBAL.STRINGS

STRINGS.NAMES.ATTACK_RABBIT = "Attack Rabbit"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ATTACK_RABBIT = "It's tougher than it looks!"



local function fn(Sim)
  local inst = CreateEntity()
  inst.entity:AddTransform()
  inst.entity:AddAnimState()

  MakeInventoryPhysics(inst)
  
  inst.AnimState:SetBank("rabbit")
  inst.AnimState:SetBuild("rabbit_build")
  inst.AnimState:PlayAnimation("idle")

  inst:AddComponent("inventoryitem")
  -- inst.components.inventoryitem.atlasname = "images/inventoryimages/myprefab.xml"

  inst:AddComponent("inspectable")


  inst.components.inventoryitem:ChangeImageName("beard_monster")
  -- inst.components.health.murdersound = beardsounds.hurt

    
  return inst
end




-- Finally, return a new prefab with the construction function and assets.
return Prefab( "common/inventory/attack_rabbit", fn, assets)




