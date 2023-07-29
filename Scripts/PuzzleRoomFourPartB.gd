extends Node2D

onready var textbox = $Player/Textbox
onready var dumpsterCat = $DumpsterCat
onready var player = $Player
onready var portal = $PortalToPrevPart
onready var oneorderCheck00 = $PuzzleBlock1/OrderCheck00
onready var oneorderCheck01 = $PuzzleBlock1/OrderCheck01
onready var oneorderCheck02 = $PuzzleBlock1/OrderCheck02
onready var oneorderCheck03 = $PuzzleBlock1/OrderCheck03

onready var oneorderCheck10 = $PuzzleBlock1/OrderCheck10
onready var oneorderCheck11 = $PuzzleBlock1/OrderCheck11
onready var oneorderCheck12 = $PuzzleBlock1/OrderCheck12
onready var oneorderCheck13 = $PuzzleBlock1/OrderCheck13

onready var oneorderCheck20 = $PuzzleBlock1/OrderCheck20
onready var oneorderCheck21 = $PuzzleBlock1/OrderCheck21
onready var oneorderCheck22 = $PuzzleBlock1/OrderCheck22
onready var oneorderCheck23 = $PuzzleBlock1/OrderCheck23

onready var oneorderCheck30 = $PuzzleBlock1/OrderCheck30
onready var oneorderCheck31 = $PuzzleBlock1/OrderCheck31
onready var oneorderCheck32 = $PuzzleBlock1/OrderCheck32
onready var oneorderCheck33 = $PuzzleBlock1/OrderCheck33

onready var twoorderCheck00 = $PuzzleBlock1/OrderCheck00
onready var twoorderCheck01 = $PuzzleBlock1/OrderCheck01
onready var twoorderCheck02 = $PuzzleBlock1/OrderCheck02
onready var twoorderCheck03 = $PuzzleBlock1/OrderCheck03

onready var twoorderCheck10 = $PuzzleBlock1/OrderCheck10
onready var twoorderCheck11 = $PuzzleBlock1/OrderCheck11
onready var twoorderCheck12 = $PuzzleBlock1/OrderCheck12
onready var twoorderCheck13 = $PuzzleBlock1/OrderCheck13

onready var twoorderCheck20 = $PuzzleBlock1/OrderCheck20
onready var twoorderCheck21 = $PuzzleBlock1/OrderCheck21
onready var twoorderCheck22 = $PuzzleBlock1/OrderCheck22
onready var twoorderCheck23 = $PuzzleBlock1/OrderCheck23

onready var twoorderCheck30 = $PuzzleBlock1/OrderCheck30
onready var twoorderCheck31 = $PuzzleBlock1/OrderCheck31
onready var twoorderCheck32 = $PuzzleBlock1/OrderCheck32
onready var twoorderCheck33 = $PuzzleBlock1/OrderCheck33

onready var threeorderCheck00 = $PuzzleBlock1/OrderCheck00
onready var threeorderCheck01 = $PuzzleBlock1/OrderCheck01
onready var threeorderCheck02 = $PuzzleBlock1/OrderCheck02
onready var threeorderCheck03 = $PuzzleBlock1/OrderCheck03

onready var threeorderCheck10 = $PuzzleBlock1/OrderCheck10
onready var threeorderCheck11 = $PuzzleBlock1/OrderCheck11
onready var threeorderCheck12 = $PuzzleBlock1/OrderCheck12
onready var threeorderCheck13 = $PuzzleBlock1/OrderCheck13

onready var threeorderCheck20 = $PuzzleBlock1/OrderCheck20
onready var threeorderCheck21 = $PuzzleBlock1/OrderCheck21
onready var threeorderCheck22 = $PuzzleBlock1/OrderCheck22
onready var threeorderCheck23 = $PuzzleBlock1/OrderCheck23

onready var threeorderCheck30 = $PuzzleBlock1/OrderCheck30
onready var threeorderCheck31 = $PuzzleBlock1/OrderCheck31
onready var threeorderCheck32 = $PuzzleBlock1/OrderCheck32
onready var threeorderCheck33 = $PuzzleBlock1/OrderCheck33

export var specificOrder = []
var currentCheck = 0
var boobyd = false
var demo = true
var oneArr = []
var twoArr = []
var threeArr = []

func _ready():
	setup_orderCheck_connections_one()
	for i in oneArr:
		i.player = player
		i.connect("triggeredMe", self, "check_order")
	for i in twoArr:
		i.player = player
		i.connect("triggeredMe", self, "check_order")
	for i in threeArr:
		i.player = player
		i.connect("triggeredMe", self, "check_order")
	setup_orderCheck_connections_two()
	setup_orderCheck_connections_three()
	textbox.connect("finished", self, "start_walking")
	dumpsterCat.connect("doneWalking", self, "turn_off_paused")

func start_walking():
	if boobyd:
		boobyd = false
		portal._on_Portal_body_entered(player)
	if demo and is_instance_valid(dumpsterCat) and !dumpsterCat.move:
		dumpsterCat.move = true
		player.whichScene = player.Scene.PAUSED
		player.camera.zoom.x = 1
		player.camera.zoom.y = 1
		demo = false
	
func turn_off_paused():
	print("paused off")
	player.whichScene = player.Scene.MAIN
	player.camera.zoom.x = .5
	player.camera.zoom.y = .5
	
	
func check_order(check):
	if currentCheck < specificOrder.size():
		if specificOrder[currentCheck] == check[0]:
			currentCheck += 1
		else:
			textbox.queue_text("looks like you've been booby'd - get off my property")
			currentCheck = 0
			boobyd = true
	if currentCheck == specificOrder.size():
		textbox.queue_text("stop following me!")
		
		
		
func setup_orderCheck_connections_one():
	oneArr.push_back(oneorderCheck00)
	oneArr.push_back(oneorderCheck01)
	oneArr.push_back(oneorderCheck02)
	oneArr.push_back(oneorderCheck03)

	oneArr.push_back(oneorderCheck10)
	oneArr.push_back(oneorderCheck11)
	oneArr.push_back(oneorderCheck12)
	oneArr.push_back(oneorderCheck13)

	oneArr.push_back(oneorderCheck20)
	oneArr.push_back(oneorderCheck21)
	oneArr.push_back(oneorderCheck22)
	oneArr.push_back(oneorderCheck23)

	oneArr.push_back(oneorderCheck30)
	oneArr.push_back(oneorderCheck31)
	oneArr.push_back(oneorderCheck32)
	oneArr.push_back(oneorderCheck33)
		
func setup_orderCheck_connections_two():
	twoArr.push_back(twoorderCheck00)
	twoArr.push_back(twoorderCheck01)
	twoArr.push_back(twoorderCheck02)
	twoArr.push_back(twoorderCheck03)
	
	twoArr.push_back(twoorderCheck10)
	twoArr.push_back(twoorderCheck11)
	twoArr.push_back(twoorderCheck12)
	twoArr.push_back(twoorderCheck13)
	
	twoArr.push_back(twoorderCheck20)
	twoArr.push_back(twoorderCheck21)
	twoArr.push_back(twoorderCheck22)
	twoArr.push_back(twoorderCheck23)
	
	twoArr.push_back(twoorderCheck30)
	twoArr.push_back(twoorderCheck31)
	twoArr.push_back(twoorderCheck32)
	twoArr.push_back(twoorderCheck33)
		
func setup_orderCheck_connections_three():
	threeArr.push_back(threeorderCheck00)
	threeArr.push_back(threeorderCheck01)
	threeArr.push_back(threeorderCheck02)
	threeArr.push_back(threeorderCheck03)
	
	threeArr.push_back(threeorderCheck10)
	threeArr.push_back(threeorderCheck11)
	threeArr.push_back(threeorderCheck12)
	threeArr.push_back(threeorderCheck13)
	
	threeArr.push_back(threeorderCheck20)
	threeArr.push_back(threeorderCheck21)
	threeArr.push_back(threeorderCheck22)
	threeArr.push_back(threeorderCheck23)
	
	threeArr.push_back(threeorderCheck30)
	threeArr.push_back(threeorderCheck31)
	threeArr.push_back(threeorderCheck32)
	threeArr.push_back(threeorderCheck33)
