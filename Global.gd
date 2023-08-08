extends Node

var player_initial_map_position = Vector2(160, 162)
var player_facing_direction = dirFace.RIGHT
var conversation = 0

enum dirFace {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

var score = 0
var combo = 0
var perfect = 0
var good = 0
var okay = 0
var missed = 0
var grade = "NA"


func set_score(new):
	score = new
	if score > 250000:
		grade = "A+"
	elif score > 200000:
		grade = "A"
	elif score > 150000:
		grade = "A-"
	elif score > 130000:
		grade = "B+"
	elif score > 115000:
		grade = "B"
	elif score > 100000:
		grade = "B-"
	elif score > 85000:
		grade = "C+"
	elif score > 70000:
		grade = "C"
	elif score > 55000:
		grade = "C-"
	elif score > 40000:
		grade = "D+"
	elif score > 30000:
		grade = "D"
	elif score > 20000:
		grade = "D-"
	else:
		grade = "F"
