extends Area2D

var player = null

onready var sprite = $Sprite

signal triggeredMe
signal leftMe

func _on_pressureTrigger_area_entered(area):
	emit_signal("triggeredMe")


func _on_pressureTrigger_area_exited(area):
	emit_signal("leftMe")
