extends KinematicBody2D

var FRICTION = 500
var ACCELERATION = 500
var MAX_SPEED = 80
var GRAVITY = 50

var velocity = Vector2.ZERO
var canWalk = false

onready var animatedSprite = $AnimatedSprite
onready var allInteractions = []
onready var textBox = $Textbox

func _ready():
	update_interactions()

func _physics_process(delta):
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputVector = inputVector.normalized()
	
	if Input.is_action_just_pressed("interact"):
		execute_interaction()
	
	if inputVector != Vector2.ZERO:
		velocity = velocity.move_toward(inputVector * MAX_SPEED, ACCELERATION * delta)
		if velocity.x > 0:
			animatedSprite.play("WalkRight")
		elif velocity.x < 0:
			animatedSprite.play("WalkLeft")
		elif velocity.y > 0:
			animatedSprite.play("WalkDown")
		elif velocity.y < 0:
			animatedSprite.play("WalkUp")
		
	else:
		animatedSprite.play("IdleRight")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
	
	#Interaction Methods
	
func _on_InteractionArea_area_entered(area):
	allInteractions.insert(0, area)
	#update_interactions()

func _on_InteractionArea_area_exited(area):
	allInteractions[0].numInteractions = 0
	allInteractions.erase(area)
	#update_interactions()
	
func update_interactions():
	if allInteractions:
		print("allInterac")
	else:
		textBox.hide_textbox()
		
func execute_interaction():
	if allInteractions:
		var curInteraction = allInteractions[0]
		match curInteraction.interactType:
			"print_text" : print(curInteraction.interactValue)
			"display_value" : 
				textBox.queue_text(curInteraction.interactValue)
				#if curInteraction.canGoToNextScene and curInteraction.numInteractions != 0 and Input.is_action_just_pressed("interact"):
					#curInteraction.interactType = "next_scene"
					#execute_interaction()
				#else:
					#curInteraction.numInteractions += 1
			"next_scene" : get_tree().change_scene_to(load('res://Scenes/WorldFallLevel.tscn'))
		

