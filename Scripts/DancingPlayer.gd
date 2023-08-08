extends KinematicBody2D

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _process(delta):
	var inputVector = Vector2(0,0)
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputVector = inputVector.normalized()

	animationTree.set("parameters/Walk/blend_position", inputVector)
	animationState.travel("Walk")
