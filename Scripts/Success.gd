extends Area2D

signal blockSuccess

func _on_Success_body_entered(body):
	if body.is_in_group("pushable"):
		print("got it")
		emit_signal("blockSuccess")
		

