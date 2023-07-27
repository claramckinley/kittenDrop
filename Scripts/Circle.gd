extends KinematicBody2D

var velocity = Vector2.ZERO
var ACCELERATION = 2
var RADIUS = 300
var ANGLE = 0
var CENTER

func _ready():
	set_process(true)
	CENTER = self.position

func _physics_process(delta): 
	ANGLE += ACCELERATION * delta
	var offset = Vector2(sin(ANGLE), cos(ANGLE)) * RADIUS
	var pos = CENTER + offset
	move_and_slide(pos)
