extends KinematicBody2D

var FRICTION = 500
var ACCELERATION = 500
var MAX_SPEED = 80
var GRAVITY = 50

var velocity = Vector2.ZERO
var canWalk = false
export var whichScene = 0
export var camera_bottom = 180
export var camera_top = 0
export var camera_left = 0
export var camera_right = 320
export var camera_current = true
export var push_speed = 400
var GLOBAL = Global
export var camera_zoom = .75

enum Scene {
	MAIN,
	SHANTY,
	SIDEHALL,
	VERTHALL,
	PAUSED
}

var metalDetector = load("res://Pawspector Valley/Scenes/MiscScenes/MetalDetector.tscn")
var metaldetectorOn = false
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var allInteractions = []
onready var textBox = $Textbox
onready var camera = $Camera2D
onready var inventory = $Inventory

var instance

func _ready():
	camera.zoom.x = camera_zoom
	camera.zoom.y = camera_zoom
	camera.current = camera_current
	camera.limit_bottom = camera_bottom
	camera.limit_top = camera_top
	camera.limit_right = camera_right
	camera.limit_left = camera_left
	self.global_position = GLOBAL.player_initial_map_position
	textBox.hide()

func _physics_process(delta):
	match whichScene:
		Scene.MAIN:
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
		Scene.PAUSED:
			animationState.travel("Idle")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity, Vector2(0,0), false, 4, PI/4, false)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("pushable"):
			collision.collider.apply_central_impulse(-collision.normal * 120)
	check_items_in_use()
	
func check_items_in_use():
	match PlayerInventory.equipped:
		null:
			remove_child(instance)
			metaldetectorOn = false
			MAX_SPEED = 80
		"metaldetector":
			if !metaldetectorOn:
				instance = metalDetector.instance()
				add_child(instance)
				metaldetectorOn = true
				MAX_SPEED = 20
	
func check_box_collision(motion: Vector2):
	if abs(motion.x) + abs(motion.y) > 1:
		return
	var box : = get_slide_collision(0).collider as SlideBlock
	if box:
		box.push(push_speed * motion)
	
	#Interaction Methods
	
func _on_InteractionArea_area_entered(area):
	if !metaldetectorOn && area.is_in_group("detectable"):
		pass
	elif metaldetectorOn && area.is_in_group("detectable"):
		allInteractions.insert(0, area)
		execute_interaction()
	else:
		allInteractions.insert(0, area)

func _on_InteractionArea_area_exited(area):
	if !metaldetectorOn && area.is_in_group("detectable"):
		pass
	elif metaldetectorOn && area.is_in_group("detectable"):
		allInteractions.erase(area)
	else:
		allInteractions[0].numInteractions = 0
		allInteractions.erase(area)
		
func execute_interaction():
	if allInteractions:
		var curInteraction = allInteractions[0]
		match curInteraction.interactType:
			"display_value" : 
				display_value(curInteraction)
			"npc_puzzle":
				npc_puzzle(curInteraction)
			"pick_up":
				curInteraction.get_parent().pick_up_item(self, curInteraction.interactLabel)
			"open_door":
				open_door(curInteraction)
			"detect_metal":
				textBox.show()
				textBox.queue_text("you found me!", false)
	
func check_for_what_i_want(curInteraction) -> bool:
	for i in range(9):
		if PlayerInventory.playerInventory.has(i) and PlayerInventory.playerInventory[i][0] == curInteraction.whatIWant:
			textBox.queue_text("i see you have a " + str(curInteraction.whatIWant) + " I'll just take that...", false)
			curInteraction.complete = true
			curInteraction.numInteractions = 2
			PlayerInventory.playerInventory.erase(i)
			return true
	return false
	
func open_door(curInteraction):
	get_tree().change_scene(curInteraction.interactValue[0])
	var posVector = Vector2.ZERO
	posVector.x = curInteraction.interactValue[1]
	posVector.y = curInteraction.interactValue[2]
	Global.player_initial_map_position = posVector
	
func display_value(curInteraction):
	if curInteraction.whatIWant != null:
		check_for_what_i_want(curInteraction)
	if textBox.current_state == textBox.State.READY and curInteraction.numInteractions < curInteraction.interactValue.size():
		textBox.queue_text(curInteraction.interactValue[curInteraction.numInteractions], false)
		curInteraction.numInteractions += 1
	else:
		curInteraction.numInteractions = 0
	
func npc_puzzle(curInteraction):
	if textBox.current_state == textBox.State.READY:
		if curInteraction.numInteractions <= 2:
			textBox.queue_text(curInteraction.interactValue[curInteraction.numInteractions], false)
		if !curInteraction.complete:
			textBox.queue_text(curInteraction.interactValue[curInteraction.numInteractions], false)
			if curInteraction.numInteractions == 0:
				curInteraction.numInteractions = 1
			elif curInteraction.numInteractions == 1:
				curInteraction.numInteractions = 0
				check_for_what_i_want(curInteraction)
		elif curInteraction.complete and curInteraction.numInteractions == 2:
			PlayerInventory.add_item(curInteraction.whatIHave, 1)
			curInteraction.numInteractions = 3
		else:
			textBox.queue_text("hows that " + str(curInteraction.whatIHave) + " treatin' ya", false)
