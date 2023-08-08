extends KinematicBody2D

var FRICTION = 500
var ACCELERATION = 500
var MAX_SPEED = 80
var GRAVITY = 20

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

var velocity = Vector2.ZERO

export var fallMultiplier = 2 
export var lowJumpMultiplier = 10 
export var jumpVelocity = 200 #Jump height


func _physics_process(delta):
	apply_gravity()
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector = inputVector.normalized()
	if inputVector.x != 0:
		apply_acceleration(inputVector.x)
	else:
		apply_friction()
	jump()
	velocity = move_and_slide(velocity, Vector2(0,-1))  
	
func apply_gravity():
	velocity.y += GRAVITY
	
func apply_acceleration(inputVector):
	animationTree.set("parameters/Idle/blend_position", inputVector)
	animationTree.set("parameters/Walk/blend_position", inputVector)
	animationState.travel("Walk")
	velocity.x = move_toward(velocity.x, 50 * inputVector, 20)
	
func apply_friction():
	animationState.travel("Idle")
	velocity.x = move_toward(velocity.x, 0, 15)

func jump():
	if velocity.y > 0: #Player is falling
		velocity += Vector2.UP * (-9.81) * (fallMultiplier) #Falling action is faster than jumping action | Like in mario

	elif velocity.y < 0 && Input.is_action_just_released("ui_accept"): #Player is jumping 
		velocity += Vector2.UP * (-9.81) * (lowJumpMultiplier) #Jump Height depends on how long you will hold key

	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"): 
			velocity = Vector2.UP * jumpVelocity #Normal Jump action
