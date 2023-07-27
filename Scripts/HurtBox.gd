extends Area2D

export (bool) var show_hit = true

var invincible = false setget set_invincible
onready var timer = $Timer

const hitEffect = preload("res://Effects/HitEffect.tscn")

signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = value
	if invincible:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")
		
func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)

func create_hit_effect(area):
	if show_hit:
		var effect = hitEffect.instance()
		var main = get_tree().current_scene
		main.add_child(effect)
		effect.global_position = global_position
		


func _on_Timer_timeout():
	self.invincible = false


func _on_HurtBox_invincibility_started():
	set_deferred("monitorable", false)


func _on_HurtBox_invincibility_ended():
	set_deferred("monitorable", true)
