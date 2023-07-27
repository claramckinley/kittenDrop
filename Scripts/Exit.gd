extends Area2D


func _on_Exit_area_entered(area):
	
	get_tree().change_scene_to(load('res://Scenes/RatSwarm.tscn'))
