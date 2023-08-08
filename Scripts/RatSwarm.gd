extends Node2D

onready var waveOne = $WaveOne
onready var waveTwo = $WaveTwo
onready var waveThree = $WaveThree
onready var textBox = $PlayerRatSwarm/Textbox
onready var player = $PlayerRatSwarm
var current_wave = Waves.TEXTBOX
var duration = 10

enum Waves {
	TEXTBOX,
	WAVEONE,
	WAVETWO,
	WAVETHREE
}

func _ready():
	textBox.connect("startPhase", self, "start_next_phase")

func start_next_phase():
	match current_wave:
		Waves.TEXTBOX:
			waveOne = load("res://Scenes/RatSwarm/WaveTwo.tscn").instance()
			get_tree().current_scene.add_child(waveOne)
			current_wave = Waves.WAVEONE
			waveOne.connect("waveOneComplete", self, "wave_one_textbox")
		Waves.WAVEONE:
			waveTwo = load("res://Scenes/RatSwarm/WaveTwo.tscn").instance()
			get_tree().current_scene.add_child(waveTwo)
			current_wave = Waves.WAVETWO
			waveTwo.connect("waveTwoComplete", self, "wave_two_textbox")
		Waves.WAVETWO:
			waveThree = load("res://Scenes/RatSwarm/WaveThree.tscn").instance()
			get_tree().current_scene.add_child(waveThree)
			current_wave = Waves.WAVETHREE
			player.connect("wasHit", self, "add_rat_wave_three")
		Waves.WAVETHREE:
			print("good job")
			
func wave_one_textbox():
	textBox.queue_text("well...how about this then...get 'em boys!", false)
	
func wave_two_textbox():
	textBox.queue_text("well well well i see we got a tough guy here ...no way you beat this!", false)
	
func add_rat_wave_three():
	waveThree.addRat = true
