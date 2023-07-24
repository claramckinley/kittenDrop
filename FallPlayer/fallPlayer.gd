extends KinematicBody2D

const ACCELERATION = 10
const MAX_SPEED = 100
const FRICTION = 20
const GRAVITY = 50
var velocity = Vector2.ZERO

	

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	
	if input_vector != Vector2.ZERO:
		velocity.x += input_vector.x * ACCELERATION * delta
		velocity = velocity.clamped(MAX_SPEED * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	position.y += GRAVITY * delta

	move_and_collide(velocity)
