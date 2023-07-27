extends Control

var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts
var playerStats = PlayerStats

onready var heartEmpty = $HeartUIEmpty
onready var heartFull = $HeartUIFull


func set_hearts(value):
	hearts = clamp(value, 0 , max_hearts)
	if heartFull != null:
		heartFull.rect_size.x = hearts * 16
	
func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heartEmpty != null:
		heartEmpty.rect_size.x = max_hearts * 16
	
func _ready():
	self.max_hearts = playerStats.max_health
	self.hearts = playerStats.health
	playerStats.connect("health_changed", self, "set_hearts")
	playerStats.connect("max_health_changed", self, "set_max_hearts")
