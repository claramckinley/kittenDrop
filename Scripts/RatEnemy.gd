extends KinematicBody2D

enum State {
	IDLE,
	STRAIGHT_CHASE
	REGULAR_CHASE,
	CIRCLE_CHASE,
	STRAIGHT_FIRE
}

var MAX_SPEED = 80
var ACCELERATION = 150
var FRICTION = 500
var velocity = Vector2.ZERO
var canTurn = true
var circle = null
var duration = 5
var nextRat = false
var goRight = true

var SPINACC = 2
var RADIUS = 300
var ANGLE = 0
var CENTER

export (State) var home_state = State.IDLE

signal nextRat

onready var playerDetectionZone = $PlayerDetectionZone
onready var sprite = $Sprite
onready var stats = $Stats
onready var hurtBox = $HurtBox

var current_state = State.IDLE

func _ready():
	print("new rat has been made at " + str(Time.get_time_string_from_system()))
	
func _physics_process(delta):
	seek_player()
	match current_state:
		State.IDLE:
			set_process(true)
			CENTER = self.position
			ANGLE += SPINACC * delta
			spin(ANGLE)
			#velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			#sprite.rotate(20)
			var position = (self.global_position - global_position).normalized()
			velocity = velocity.move_toward(position * MAX_SPEED, ACCELERATION * delta)
		State.STRAIGHT_CHASE:
			straight_chase()
		State.REGULAR_CHASE:
			regular_chase(delta)
		State.CIRCLE_CHASE:
			if circle != null:
				var circleDirection = (circle.global_position - global_position).normalized()
				velocity = velocity.move_toward(circleDirection * MAX_SPEED, ACCELERATION * delta)
		State.STRAIGHT_FIRE:
			straight_fire(delta)
	if(position.x >320 || position.x < 0 || position.y > 180 || position.y < 0):
		_on_HurtBox_area_entered(self)
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetectionZone.can_see_player():
		current_state = home_state
		
func _on_Stats_no_health():
	queue_free()
	
func straight_chase():
	var player = playerDetectionZone.player
	if canTurn and player != null:
		var direction = (player.global_position - global_position).normalized()
		sprite.look_at(direction)
		velocity = direction * ACCELERATION
		canTurn = false
		
func straight_fire(delta):
	var vec = Vector2.ZERO
	if goRight:
		vec.x += ACCELERATION
		sprite.flip_h
	else:
		vec.x -= ACCELERATION
	velocity = velocity.move_toward(vec * MAX_SPEED, ACCELERATION * delta)
		
func regular_chase(delta):
	var player = playerDetectionZone.player
	if player != null:
		var direction = (player.global_position - global_position).normalized()
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	else:
		current_state = State.IDLE
		sprite.flip_h = velocity.x < 0
		sprite.flip_v = velocity.y < 0
	
func spin(angle):
	var offset = Vector2(sin(angle), cos(angle)) * RADIUS
	var pos = CENTER + offset
	move_and_slide(pos)

func _on_HurtBox_area_entered(area):
	print("hey")
	queue_free()
	hurtBox.create_hit_effect(area)
	emit_signal("nextRat")
