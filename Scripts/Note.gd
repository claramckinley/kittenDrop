extends Area2D

const TARGET_Y = 164
const SPAWN_Y = -16
const DIST_TO_TARGET = TARGET_Y - SPAWN_Y

const LEFT_LANE_SPAWN = Vector2(120, SPAWN_Y)
const CENTER_LANE_SPAWN = Vector2(160, SPAWN_Y)
const RIGHT_LANE_SPAWN = Vector2(200, SPAWN_Y)

onready var sprite = $AnimatedSprite

var speed = 0
var hit = false

func _physics_process(delta):
	if !hit:
		position.y += speed * delta
		if position.y > 200:
			queue_free()
			get_parent().reset_combo()
	else:
		$Node2D.position.y -= speed * delta
		
func initialize(lane):
	if lane == 0:
		$AnimatedSprite.frame = 0
		position = LEFT_LANE_SPAWN
	elif lane == 1:
		$AnimatedSprite.frame = 1
		position = CENTER_LANE_SPAWN
	elif lane == 2:
		$AnimatedSprite.frame = 2
		position = RIGHT_LANE_SPAWN
	else:
		print("invalid lane")
		return
	speed = DIST_TO_TARGET / 2.0
	
func destroy(score):
	$CPUParticles2D.emitting = true
	$AnimatedSprite.visible = false
	$Timer.start()
	hit = true
	if score == 3:
		$Node2D/Label.text = "PERFECT"
	if score == 2:
		$Node2D/Label.text = "GOOD"
	if score == 1:
		$Node2D/Label.text = "OKAY"
	if score == 0:
		$Node2D/Label.text = "MISSED"

func _on_Timer_timeout():
	queue_free()
