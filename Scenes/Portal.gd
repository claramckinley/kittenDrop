tool

extends Area2D

export (String, FILE) var next_scene_path = ""
export (Vector2) var player_spawn_location = Vector2.ZERO
export (Global.dirFace) var player_direction = Global.dirFace.RIGHT

func get_configuration_warning() -> String:
	if next_scene_path == "":
		return "next_scene_path must be set for portal to work"
	else:
		return ""

func _on_Exit_body_entered(body):
	if get_tree().change_scene(next_scene_path) == OK:
		print("unavailable scene")
		


func _on_Portal_body_entered(body):
	Global.player_initial_map_position = player_spawn_location
	Global.player_facing_direction = player_direction
	if get_tree().change_scene(next_scene_path) != OK:
		print("unavailable next scene path")
