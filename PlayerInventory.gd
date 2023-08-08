extends Node

var numInventorySlots = 9
var equipped = null
var playerInventory = {
	0: ["heart", 1]
}

func add_item(item_name, item_quantity):
	for item in playerInventory:
		if playerInventory[item][0] == item_name:
			playerInventory[item][1] += item_quantity
			return
	for i in range(numInventorySlots):
		if playerInventory.has(i) == false:
			playerInventory[i] = [item_name, item_quantity]
			return
