extends Area2D

var player = null
export var orderCheckNum = "10"

onready var sprite = $Sprite

signal triggeredMe

func _ready():
	sprite.self_modulate.a = 0

func _on_OrderCheck_body_entered(body):
	if player != null and body == player:
		sprite.self_modulate.a = .5
		emit_signal("triggeredMe", [orderCheckNum])
