extends CanvasLayer

const CHAR_READ_RATE = 0.05

onready var textbox_container = $TextboxContainer
onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []


# Called when the node enters the scene tree for the first time.
func _ready():
	#hide_textbox()
	queue_text("welcome back to the world lil kitten")
	
func _process(delta):
	match current_state:
		State.READY:
			if !text_queue.empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.percent_visible = 1.0
				$Tween.stop_all()
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				hide_textbox();
	
func hide_textbox():
	label.text = ""
	textbox_container.hide()
	
func show_textbox():
	textbox_container.show()
	
func display_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	print(label.text)
	label.percent_visible = 0.0
	change_state(State.READING)
	show_textbox()
	$Tween.interpolate_property(label, "percent_visible", 0.0, 1.0, len(next_text) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
func queue_text(next_text):
	text_queue.push_back(next_text)


func _on_Tween_tween_all_completed():
	change_state(State.FINISHED)
	
func change_state(next_state):
	current_state = next_state
