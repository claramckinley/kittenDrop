extends KinematicBody2D

var move = false setget set_move
var ACCELERATION = 50
var MAX_SPEED = 80
var FRICTION = 500
var leg = Leg.NONE 
var velocity = Vector2.ZERO

signal doneWalking

enum Leg {
	NONE
	LEGONE,
	LEGTWO,
	LEGTHREE,
	LEGFOUR,
	LEGFIVE,
	LEGSIX,
	LEGSEVEN,
	LEGEIGHT,
	LEGNINE,
	LEGTEN,
	LEGELEVEN
	DONE
}

enum Part{
	A,
	B,
	C
}

export var part = 0

func set_move(value):
	print(move)
	move = value
	if move:
		leg = Leg.LEGONE
	
func _physics_process(delta):
	if leg != Leg.NONE and Input.is_action_just_pressed("interact"):
		ACCELERATION = 200
	match part:
		Part.A:
			part_a(delta)
		Part.B:
			part_b(delta)
		Part.C:
			part_c(delta)
		
				
func part_a(delta):
	match leg:
		Leg.NONE:
			pass
		Leg.LEGONE:
			position.x += ACCELERATION * delta
			if position.x >= 90:
				leg = Leg.LEGTWO
		Leg.LEGTWO:
			position.y -= ACCELERATION * delta
			if position.y <= 18:
				leg = Leg.LEGTHREE
		Leg.LEGTHREE:
			position.x += ACCELERATION * delta
			if position.x >= 146:
				leg = Leg.LEGFOUR
		Leg.LEGFOUR:
			position.y += ACCELERATION * delta
			if position.y >= 165:
				leg = Leg.LEGFIVE
		Leg.LEGFIVE:
			position.x += ACCELERATION * delta
			if position.x >= 200:
				leg = Leg.LEGSIX
		Leg.LEGSIX:
			position.y -= ACCELERATION * delta
			if position.y <= 66:
				leg = Leg.LEGSEVEN
		Leg.LEGSEVEN:
			position.x += ACCELERATION * delta
			if position.x >= 257:
				leg = Leg.LEGEIGHT
		Leg.LEGEIGHT:
			position.y += ACCELERATION * delta
			if position.y >= 166:
				leg = Leg.LEGNINE
		Leg.LEGNINE:
			position.x += ACCELERATION * delta
			if position.x >= 340:
				leg = Leg.DONE
				emit_signal("doneWalking")
				queue_free()

func part_b(delta):
	match leg:
		Leg.NONE:
			pass
		Leg.LEGONE:
			position.y += ACCELERATION * delta
			if position.y >= 165:
				leg = Leg.LEGTWO
		Leg.LEGTWO:
			position.x += ACCELERATION * delta
			if position.x >= 89:
				leg = Leg.LEGTHREE
		Leg.LEGTHREE:
			position.x += ACCELERATION * delta
			if position.x >= 146:
				leg = Leg.LEGFOUR
		Leg.LEGFOUR:
			position.y -= ACCELERATION * delta
			if position.y <= 65:
				leg = Leg.LEGFIVE
		Leg.LEGFIVE:
			position.x -= ACCELERATION * delta
			if position.x <= 89:
				leg = Leg.LEGSIX
		Leg.LEGSIX:
			position.y -= ACCELERATION * delta
			if position.y <= 18:
				leg = Leg.LEGSEVEN
		Leg.LEGSEVEN:
			position.x += ACCELERATION * delta
			if position.x >= 200:
				leg = Leg.LEGEIGHT
		Leg.LEGEIGHT:
			position.y += ACCELERATION * delta
			if position.y >= 166:
				leg = Leg.LEGNINE
		Leg.LEGNINE:
			position.x += ACCELERATION * delta
			if position.x >= 257:
				leg = Leg.LEGTEN
		Leg.LEGTEN:
			position.y -= ACCELERATION * delta
			if position.y <= 66:
				leg = Leg.LEGELEVEN
		Leg.LEGELEVEN:
			position.x += ACCELERATION * delta
			if position.x >= 340:
				leg = Leg.DONE
				emit_signal("doneWalking")
				queue_free()

func part_c(delta):
	match leg:
		Leg.NONE:
			pass
		Leg.LEGONE:
			position.x += ACCELERATION * delta
			if position.x >= 90:
				leg = Leg.LEGTWO
		Leg.LEGTWO:
			position.y -= ACCELERATION * delta
			if position.y <= 18:
				leg = Leg.LEGTHREE
		Leg.LEGTHREE:
			position.x += ACCELERATION * delta
			if position.x >= 146:
				leg = Leg.LEGFOUR
		Leg.LEGFOUR:
			position.y += ACCELERATION * delta
			if position.y >= 165:
				leg = Leg.LEGFIVE
		Leg.LEGFIVE:
			position.x += ACCELERATION * delta
			if position.x >= 200:
				leg = Leg.LEGSIX
		Leg.LEGSIX:
			position.y -= ACCELERATION * delta
			if position.y <= 66:
				leg = Leg.LEGSEVEN
		Leg.LEGSEVEN:
			position.x += ACCELERATION * delta
			if position.x >= 257:
				leg = Leg.LEGEIGHT
		Leg.LEGEIGHT:
			position.y += ACCELERATION * delta
			if position.y >= 166:
				leg = Leg.LEGNINE
		Leg.LEGNINE:
			position.x += ACCELERATION * delta
			if position.x >= 300:
				leg = Leg.DONE
				emit_signal("doneWalking")
