extends VBoxContainer

signal submitted

onready var dieNumber = $DieNumber
onready var numDie = $NumberOfDice
onready var button = $BluffCallChoices/Button

var numDieIndex = 0
var dieNumIndex = 0



func _ready():
	add_items_to_die_num()
	add_items_to_num_die()

func add_items_to_die_num():
	dieNumber.add_item("1")
	dieNumber.add_item("2")
	dieNumber.add_item("3")
	dieNumber.add_item("4")
	dieNumber.add_item("5")
	dieNumber.add_item("6")
	
func add_items_to_num_die():
	numDie.add_item("1")
	numDie.add_item("2")
	numDie.add_item("3")
	numDie.add_item("4")
	numDie.add_item("5")
	numDie.add_item("6")
	
func reset_options(numDiceBet, diceNumBet):
	numDie.clear()
	dieNumber.clear()
	for i in range(numDiceBet, 7):
		numDie.add_item(str(i))
	for i in range(diceNumBet, 7):
		dieNumber.add_item(str(i))


func _on_DieNumber_item_selected(index):
	dieNumIndex =  index
	

func _on_NumberOfDice_item_selected(index):
	numDieIndex =  index
	
func _on_Button_pressed():
	print(dieNumIndex)
	if numDieIndex != -1 and dieNumIndex != -1:
		emit_signal("submitted", dieNumIndex, numDieIndex)
	else:
		print("pick some numbers")
