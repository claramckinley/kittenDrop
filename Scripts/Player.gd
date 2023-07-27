extends KinematicBody2D

var FRICTION = 500
var ACCELERATION = 500
var MAX_SPEED = 80
var GRAVITY = 50

var velocity = Vector2.ZERO
var canWalk = false
export var whichScene = 0
var GLOBAL = Global

enum Scene {
	MAIN,
	SIDEHALL,
	VERTHALL
}

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var allInteractions = []
onready var textBox = $Textbox
onready var camera = $Camera2D

func _ready():
	self.global_position = GLOBAL.player_initial_map_position
#	match Global.player_facing_direction:
#		Global.dirFace.UP:
#			animationPlayer.play("IdleUp")
#		Global.dirFace.DOWN:
#			animationPlayer.play("IdleDown")
#		Global.dirFace.LEFT:
#			animationPlayer.play("IdleLeft")
#		Global.dirFace.RIGHT:
#			animationPlayer.play("IdleRight")
	update_interactions()

func _physics_process(delta):
	match whichScene:
		Scene.MAIN:
			camera.current = true
			var inputVector = Vector2.ZERO
			inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
			inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
			inputVector = inputVector.normalized()
			
			if Input.is_action_just_pressed("interact"):
				execute_interaction()
			
			if inputVector != Vector2.ZERO:
				animationTree.set("parameters/Idle/blend_position", inputVector)
				animationTree.set("parameters/Walk/blend_position", inputVector)
				animationState.travel("Walk")
				velocity = velocity.move_toward(inputVector * MAX_SPEED, ACCELERATION * delta)
			else:
				animationState.travel("Idle")
				velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		Scene.SIDEHALL:
			camera.current = false
			var inputVector = Vector2.ZERO
			inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
			inputVector.y = GRAVITY * delta
			inputVector = inputVector.normalized()
			if inputVector.x != 0:
				animationTree.set("parameters/Idle/blend_position", inputVector)
				animationTree.set("parameters/Walk/blend_position", inputVector)
				animationState.travel("Walk")
				velocity = velocity.move_toward(inputVector * MAX_SPEED, ACCELERATION * delta)
			else:
				animationState.travel("Idle")
				velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		Scene.VERTHALL:
			camera.current = false
			var inputVector = Vector2.ZERO
			inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
			inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
			inputVector = inputVector.normalized()
			if inputVector != Vector2.ZERO:
				animationTree.set("parameters/Idle/blend_position", inputVector)
				animationTree.set("parameters/Walk/blend_position", inputVector)
				animationState.travel("Walk")
				velocity = velocity.move_toward(inputVector * MAX_SPEED, ACCELERATION * delta)
			else:
				animationState.travel("Idle")
				velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
	
	#Interaction Methods
	
func _on_InteractionArea_area_entered(area):
	allInteractions.insert(0, area)

func _on_InteractionArea_area_exited(area):
	allInteractions[0].numInteractions = 0
	allInteractions.erase(area)
	
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
				if curInteraction.canGoToNextScene or curInteraction.numInteractions != 0 and Input.is_action_just_pressed("interact"):
					curInteraction.interactType = "next_scene"
					execute_interaction()
				else:
					curInteraction.numInteractions += 1
			"next_scene" : get_tree().change_scene_to(load('res://Scenes/RatSwarm/RatSwarm.tscn'))



func _on_Exit_area_entered(area):
	print("leaving!")
	#get_tree().change_scene_to(load('res://Scenes/RatSwarm/RatSwarm.tscn'))
