extends Node2D

onready var success = $Board/Success
onready var textbox = $Player/Textbox

func _on_Success_blockSuccess():
	textbox.queue_text("good job!", false)
