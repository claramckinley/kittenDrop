extends Node2D

var numRats = 0
var addRat = false setget set_rat
var numObstacles = 5
var allRats = []

onready var ratEnemy = $RatEnemy

func _ready():
	populate_obstacles(numObstacles)
	
func set_rat(value):
	addRat = value
	if addRat:
		add_rat()
	
func add_rat():
	var ratEnemy = load("res://Scenes/RatSwarm/RatEnemy.tscn").instance()
	ratEnemy.home_state = ratEnemy.State.REGULAR_CHASE
	ratEnemy.current_state = ratEnemy.home_state
	ratEnemy.position.x = 320 * rand_range(0, 1)
	ratEnemy.position.y = 180 * rand_range(0, 1)
	get_tree().current_scene.add_child(ratEnemy)
	ratEnemy.connect("nextRat", self, "add_rat")
	addRat = false
	
func populate_obstacles(value):
	randomize()
	for i in value:
		var obstacle = load("res://Scenes/RatSwarm/Obstacle.tscn").instance()
		obstacle.position.x = 300 * rand_range(0, 1)
		obstacle.position.y = 160 * rand_range(0, 1)
		get_tree().current_scene.add_child(obstacle)
