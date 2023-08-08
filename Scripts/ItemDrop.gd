extends KinematicBody2D

const ACCELERATION = 460
const MAX_SPEED = 225
var velocity = Vector2.ZERO
var item_name

export var sprite = ""

var player = null
var being_picked_up = false

func _ready():
	print(sprite)
	$Sprite.texture = load(sprite)
	$Sprite.scale.x = .1
	$Sprite.scale.y = .1

func _physics_process(delta):
	if being_picked_up:
		var direction = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		
		var distance = global_position.distance_to(player.global_position)
		if distance < 15:
			PlayerInventory.add_item(item_name, 1)
			queue_free()
	velocity = move_and_slide(velocity, Vector2.UP)

func pick_up_item(body, this_item_name):
	player = body
	item_name = this_item_name
	being_picked_up = true
