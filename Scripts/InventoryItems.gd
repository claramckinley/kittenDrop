extends Node2D


var item_name
var item_quantity = 1
var max_quantity = 10
var is_equipped = false

onready var label = $Label
onready var obj_label = $objectLabel

#signal equip
		
func set_item(nm, qt):
	item_name = nm
	item_quantity = qt
	obj_label.text = item_name
	if item_quantity == 1:
		label.visible = false
	else:
		label.text = str(item_quantity)
	if PlayerInventory.equipped == nm:
		obj_label.text += " (equipped)"
		is_equipped = true

func add_item_quantity(amount):
	item_quantity += amount
	label.visible = true
	label.text = str(item_quantity)
	
func remove_item_quantity(amount):
	item_quantity -= amount	
	label.text = str(item_quantity)
	
func equip_item():
#	PlayerInventory.playerInventory[PlayerInventory.equipped][0] = PlayerInventory.playerInventory[PlayerInventory.equipped][0].item_name
	if !is_equipped:
		obj_label.text += " (equipped)"
		is_equipped = true
		PlayerInventory.equipped = item_name
#		emit_signal("equip", item_name)
#	num_equpped += 1
	else:
		obj_label.text = item_name
		is_equipped = false
		PlayerInventory.equipped = null
#		num_equpped -= 1
	
func is_active(value):
	if value:
		obj_label.add_color_override("font_color", Color("#e8ed4c"))
	else:
		obj_label.add_color_override("font_color", Color("#ffffff"))
