extends Label

var itemClass = preload("res://Pawspector Valley/Scenes/MiscScenes/InventoryItems.tscn")
var item = null

#signal equipping
		
func initialize_item(item_name, item_quantity):
	if item == null:
		item = itemClass.instance()
		add_child(item)
		item.set_item(item_name, item_quantity)
#		item.connect("equip", self, "send_it_up")
	else:
		item.set_item(item_name, item_quantity)
		
func send_it_up(item_name):
	print("send it up")
#	emit_signal("equipping",item_name)

func pick_from_slot():
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null
	#update slot styles here at some point
	
func put_in_slot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.remove_child(item)
	add_child(item)
	#update slot styles here at some point
	
func equip_item():
	if item != null:
		item.equip_item()

func is_active(value):
	if item != null:
			item.is_active(value)
