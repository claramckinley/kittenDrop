extends Node2D

export var numObstacles = 3;
export var maxRats = 10

signal waveTwoBeginning
signal waveTwoComplete

var phase  = 1
var canGoToNextPhase = true
var numPhases = 2
var numRats = 1
var maxRatsAtOnce = 2
var yLoc = 100 / maxRats
var xLoc = 30
var acc = 100
var rats = []
var whichRats = 0

onready var rat = $RatEnemy

func _ready():
	populate_rats()
	rat.connect("nextRat", self, "trigger_next_rat")	
		
func populate_rats():
	print("POPULATING")
	for i in maxRats:
		var ratEnemyLeft = load("res://Scenes/RatSwarm/RatEnemy.tscn").instance()
		ratEnemyLeft.home_state = ratEnemyLeft.State.STRAIGHT_FIRE
		ratEnemyLeft.ACCELERATION = 0
		ratEnemyLeft.current_state = ratEnemyLeft.State.IDLE
		ratEnemyLeft.position.x = 32
		ratEnemyLeft.position.y = yLoc
		get_tree().current_scene.add_child(ratEnemyLeft)
		rats.push_front(ratEnemyLeft)
		#ratEnemyLeft.connect("nextRat", self, "trigger_next_rat")
		var ratEnemyRight = load("res://Scenes/RatSwarm/RatEnemy.tscn").instance()
		ratEnemyRight.home_state = ratEnemyRight.State.STRAIGHT_FIRE
		ratEnemyRight.ACCELERATION = 0
		ratEnemyRight.current_state = ratEnemyRight.State.IDLE
		ratEnemyRight.position.x = 320 - 32
		ratEnemyRight.position.y = yLoc
		ratEnemyRight.goRight = false
		get_tree().current_scene.add_child(ratEnemyRight)
		rats.push_front(ratEnemyRight)
		#ratEnemyRight.connect("nextRat", self, "trigger_next_rat")
		yLoc +=  160 / maxRats
	
	#canGoToNextPhase = true
		
func trigger_next_rat():
	#send_random_rats()
	send_specific_rats()
			
func send_random_rats():
	randomize()
	var numRatsAtOnce = int(round(rand_range(1, maxRatsAtOnce)))
	if !rats.empty():
		print("next rat " + str(numRatsAtOnce))
		for i in numRatsAtOnce:
			var randRat = rand_range(0, rats.size() - 1)
			if randRat >= 0:
				var nextRat = rats[randRat]
				nextRat.current_state = nextRat.State.STRAIGHT_FIRE
				nextRat.ACCELERATION = acc
				rats.remove(randRat)
	else:
		if canGoToNextPhase and phase < numPhases:
			print("next phase")
			phase += 1
			yLoc = 100 / maxRats
			populate_rats()
			var newPhaseFirstRat = load("res://Scenes/RatSwarm/RatEnemy.tscn").instance()
			newPhaseFirstRat.home_state = newPhaseFirstRat.State.STRAIGHT_FIRE
			newPhaseFirstRat.ACCELERATION = acc
			newPhaseFirstRat.current_state = newPhaseFirstRat.home_state
			newPhaseFirstRat.position.x = 320 * rand_range(0, 1)
			newPhaseFirstRat.position.y = 180 * rand_range(0, 1)
			get_tree().current_scene.add_child(newPhaseFirstRat)
			newPhaseFirstRat.connect("nextRat", self, "trigger_next_rat")	
			canGoToNextPhase = false
		else:
			print("ending")
			queue_free()
			emit_signal("waveTwoComplete")

func send_specific_rats():
	print(whichRats)
	match whichRats:
		0:
			var nextRat = rats[0]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat = rats[5]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat = rats[10]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat.connect("nextRat", self, "trigger_next_rat")
		1:
			var nextRat = rats[3]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat = rats[4]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat = rats[12]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat.connect("nextRat", self, "trigger_next_rat")
		2:
			var nextRat = rats[1]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat = rats[6]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat.connect("nextRat", self, "trigger_next_rat")
		3:
			var nextRat = rats[18]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat = rats[15]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat = rats[2]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat.connect("nextRat", self, "trigger_next_rat")
		4:
			var nextRat = rats[19]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat = rats[16]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat = rats[7]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat.connect("nextRat", self, "trigger_next_rat")
		5:
			var nextRat = rats[8]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat = rats[9]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat.connect("nextRat", self, "trigger_next_rat")
		6:
			var nextRat = rats[11]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat = rats[13]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat.connect("nextRat", self, "trigger_next_rat")
		7:
			var nextRat = rats[14]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat = rats[17]
			nextRat.current_state = nextRat.State.STRAIGHT_FIRE
			nextRat.ACCELERATION = acc
			nextRat.connect("nextRat", self, "trigger_next_rat")
		8:
			if phase < numPhases:
				yLoc = 100 / maxRats
				populate_rats()
				var newPhaseFirstRat = load("res://Scenes/RatSwarm/RatEnemy.tscn").instance()
				newPhaseFirstRat.home_state = newPhaseFirstRat.State.STRAIGHT_FIRE
				newPhaseFirstRat.ACCELERATION = acc
				newPhaseFirstRat.current_state = newPhaseFirstRat.home_state
				newPhaseFirstRat.position.x = 320 * rand_range(0, 1)
				newPhaseFirstRat.position.y = 180 * rand_range(0, 1)
				get_tree().current_scene.add_child(newPhaseFirstRat)
				newPhaseFirstRat.connect("nextRat", self, "trigger_next_rat")	
				phase += 1
				whichRats = 0
		9:
			print("ending")
			queue_free()
			emit_signal("waveTwoComplete")
	whichRats += 1
