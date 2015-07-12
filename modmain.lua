


PrefabFiles = {
  "attack_rabbit_def",
}


SpawnPrefab = GLOBAL.SpawnPrefab

function PlayerInit(player)
  print("Firing Attack Rabbits!!!")
  local prefab = SpawnPrefab("attack_rabbit")
  player.components.inventory:GiveItem(prefab)
end

AddPlayerPostInit(PlayerInit)
