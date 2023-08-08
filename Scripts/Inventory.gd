extends Node2D

const slotClass = preload("res://Scripts/Slot.gd")
onready var inventory_slots = $InventoryContainer/MarginContainer/HBoxContainer.get_children()
var index = 0
var holding_item = null

export var category = ""

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		inventory_slots[index].is_active(false)
		if index == 0:
			index = PlayerInventory.playerInventory.size()
		index -= 1
	if Input.is_action_just_pressed("ui_down"):
		inventory_slots[index].is_active(false)
		if index == PlayerInventory.playerInventory.size() - 1:
			index = -1
		index += 1
	inventory_slots[index].is_active(true)
	if visible == true && Input.is_action_just_pressed("ui_accept"):
		inventory_slots[index].equip_item()

func initialize_inventory():
	for i in range(inventory_slots.size()):
		if PlayerInventory.playerInventory.has(i):
			inventory_slots[i].initialize_item(PlayerInventory.playerInventory[i][0], PlayerInventory.playerInventory[i][1])



#func slot_gui_input(event: InputEvent, slot: slotClass):
#		if event is InputEventMouseButton:
#			if event.button_index == BUTTON_LEFT && event.pressed:
#				if holding_item != null:
#					if !slot.item: #place item in empty slot
#						slot.put_in_slot(holding_item)
#						holding_item = null
#					else: # not empty slot then swap items
#						if holding_item.item_name != slot.item.item_name:
#							var temp_item = slot.item
#							slot.pick_from_slot()
#							temp_item.global_position = event.global_position
#							slot.put_in_slot(holding_item)
#							holding_item = temp_item
#						else:
#							var canAddThisMuch = slot.item.max_quantity - slot.item.item_quantity
#							if canAddThisMuch >= slot.item.item_quantity + holding_item.item_quantity:
#								slot.item.add_item_quantity(holding_item.item_quantity)
#								holding_item.queue_free()
#								holding_item = null
#							else:
#								slot.item.add_item_quantity(canAddThisMuch)
#								holding_item.remove_item_quantity(canAddThisMuch)
#				elif slot.item:
#					holding_item = slot.item
#					slot.pick_from_slot()
#					holding_item.global_position = get_global_mouse_position()
		
#func _input(event):
#	if is_instance_valid(holding_item) and holding_item:
#		holding_item.global_position = get_global_mouse_position()

