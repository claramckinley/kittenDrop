extends TextureButton

signal passed

func _on_PASS_pressed():
	emit_signal("passed")
