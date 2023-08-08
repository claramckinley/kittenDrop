extends Node2D

onready var pressureTrigger = $pressureTrigger

var numActive = 0

func _ready():
	pressureTrigger.connect("triggeredMe", self, "turned_on")
	pressureTrigger.connect("leftMe", self, "turned_off")
	
func _process(delta):
	if numActive == 3:
		print("got it")

func turned_on():
	numActive += 1
	
func turned_off():
	numActive -= 1
	

	
