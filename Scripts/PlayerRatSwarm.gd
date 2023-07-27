extends KinematicBody2D

export var FRICTION = 500
export var ACCELERATION = 500
export var MAX_SPEED = 80

var velocity = Vector2.ZERO
onready var textBox = $Textbox
onready var hurtBox = $HurtBox

var playerStats = PlayerStats

signal wasHit

func _ready():
	playerStats.connect("no_health", self, "death_options")
	textBox.queue_text("welcome to the rat swarm...")

func _physics_process(delta):
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputVector = inputVector.normalized()
	
	if inputVector != Vector2.ZERO:
		velocity = velocity.move_toward(inputVector * MAX_SPEED, ACCELERATION * delta)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)

func _on_HurtBox_area_entered(area):
	playerStats.health -= 1
	hurtBox.start_invincibility(0.5)
	hurtBox.create_hit_effect(area)
	emit_signal("wasHit")
	
func death_options():
	queue_free()
	get_tree().change_scene("res://Scenes/RatSwarm/DeathMenu.tscn")
	
