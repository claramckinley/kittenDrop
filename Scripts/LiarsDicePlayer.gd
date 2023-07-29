extends StaticBody2D

var myTurn = true setget on_my_turn

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_my_turn(value):
	myTurn = value
