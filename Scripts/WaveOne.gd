extends Node2D

var phase = 1
export var numPhases = 3
export var maxRats = 4
export var acc = 200
var rats = []

onready var rat = $RatEnemy

signal waveOneComplete

func _ready():
	populate_rats()
	rat.connect("nextRat", self, "trigger_next_rat")
		
func populate_rats():
	randomize()
	for i in maxRats:
		var ratEnemyLeft = load("res://Scenes/RatSwarm/RatEnemy.tscn").instance()
		ratEnemyLeft.home_state = ratEnemyLeft.State.STRAIGHT_CHASE
		ratEnemyLeft.ACCELERATION = 0
		ratEnemyLeft.current_state = ratEnemyLeft.State.IDLE
		ratEnemyLeft.position.x = 320 * rand_range(0, 1)
		ratEnemyLeft.position.y = 180 * rand_range(0, 1)
		get_tree().current_scene.add_child(ratEnemyLeft)
		rats.push_front(ratEnemyLeft)
		ratEnemyLeft.connect("nextRat", self, "trigger_next_rat")
		
func trigger_next_rat():
	randomize()
	if !rats.empty():
		var randRat = rand_range(0, rats.size())
		var nextRat = rats[randRat]
		if nextRat != null:
			nextRat.current_state = nextRat.State.STRAIGHT_CHASE
			nextRat.ACCELERATION = acc
			nextRat.canTurn = true
			rats.remove(randRat)
	else:
		if phase < numPhases:
			phase += 1
			maxRats = maxRats * 1.2
			populate_rats()
			var newPhaseFirstRat = load("res://Scenes/RatSwarm/RatEnemy.tscn").instance()
			newPhaseFirstRat.home_state = newPhaseFirstRat.State.STRAIGHT_CHASE
			newPhaseFirstRat.ACCELERATION = acc
			newPhaseFirstRat.current_state = newPhaseFirstRat.home_state
			newPhaseFirstRat.position.x = 320 * rand_range(0, 1)
			newPhaseFirstRat.position.y = 180 * rand_range(0, 1)
			get_tree().current_scene.add_child(newPhaseFirstRat)
			newPhaseFirstRat.connect("nextRat", self, "trigger_next_rat")	
		else:
			queue_free()
			emit_signal("waveOneComplete")
