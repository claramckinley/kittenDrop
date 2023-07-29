extends TextureButton

signal called

func _on_CALL_pressed():
	emit_signal("called")
