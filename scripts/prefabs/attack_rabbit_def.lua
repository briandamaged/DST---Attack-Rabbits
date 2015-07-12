local assets =
{
    Asset("ANIM", "anim/ds_rabbit_basic.zip"),
    Asset("ANIM", "anim/rabbit_build.zip"),
    Asset("ANIM", "anim/beard_monster.zip"),
    Asset("ANIM", "anim/rabbit_winter_build.zip"),
    Asset("SOUND", "sound/rabbit.fsb"),
}


STRINGS.NAMES.ATTACK_RABBIT = "Attack Rabbit"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ATTACK_RABBIT = "It's tougher than it looks!"


local rabbitsounds =
{
    scream = "dontstarve/rabbit/beardscream",
    hurt = "dontstarve/rabbit/beardscream_short",
}



local function RetargetFn(inst)
    -- if inst.sg:HasStateTag("hidden") then return end
    return FindEntity(inst, TUNING.WARG_TARGETRANGE, function(guy)
        return inst.components.combat:CanTarget(guy) 
    end,
    nil,
    {"wall","warg","hound"}
    )
end


local function KeepTargetFn(inst, target)
    -- if inst.sg:HasStateTag("hidden") then return end
    if target then
        return distsq(inst:GetPosition(), target:GetPosition()) < 40*40
        and not target.components.health:IsDead()
        and inst.components.combat:CanTarget(target)
    end
end



local AttackRabbitBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)


function AttackRabbitBrain:OnStart()
    local root = 
    PriorityNode(
    {
        ChaseAndAttack(self.inst),
        StandStill(self.inst),
    }, .25)
    self.bt = BT(self.inst, root)
end



local function fn(Sim)
  local inst = CreateEntity()
  inst.entity:AddTransform()
  inst.entity:AddAnimState()


  inst.entity:AddSoundEmitter()
  inst.sounds = rabbitsounds

  MakeInventoryPhysics(inst)
  
  inst.AnimState:SetBank("rabbit")
  inst.AnimState:SetBuild("rabbit_build")
  inst.AnimState:PlayAnimation("idle")

  inst:AddComponent("inventoryitem")
  -- inst.components.inventoryitem.atlasname = "images/inventoryimages/myprefab.xml"

  inst:AddComponent("inspectable")


  inst.components.inventoryitem:ChangeImageName("beard_monster")
  -- inst.components.health.murdersound = beardsounds.hurt



  inst:AddComponent("locomotor")
  inst.components.locomotor.runspeed = TUNING.WARG_RUNSPEED
  inst.components.locomotor:SetShouldRun(true)



  inst:AddComponent("combat")
  inst.components.combat:SetDefaultDamage(TUNING.WARG_DAMAGE)
  inst.components.combat:SetRange(TUNING.WARG_ATTACKRANGE)
  inst.components.combat:SetAttackPeriod(TUNING.WARG_ATTACKPERIOD)
  inst.components.combat:SetRetargetFunction(1, RetargetFn)
  inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
  inst.components.combat:SetHurtSound("dontstarve_DLC001/creatures/vargr/hit")



  inst:AddComponent("health")
  inst.components.health:SetMaxHealth(TUNING.RABBIT_HEALTH)
  inst:SetBrain(AttackRabbitBrain)

  -- inst:SetStateGraph("SGwarg")
  inst:SetStateGraph("SGrabbit")

  return inst
end




-- Finally, return a new prefab with the construction function and assets.
return Prefab( "common/inventory/attack_rabbit", fn, assets)




