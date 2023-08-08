extends CanvasLayer

const CHAR_READ_RATE = 0.05

onready var textbox_container = $TextboxContainer
onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label
onready var button = $TextboxContainer/MarginContainer/HBoxContainer/AcceptButton

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []
var prev_text = ""

signal startPhase
signal finished
signal accepted

func _ready():
	button.visible = false


func _process(delta):
	match current_state:
		State.READY:
			if !text_queue.empty():
				display_text()
			else:
				prev_text = ""
		State.READING:
			if Input.is_action_just_pressed("textbox"):
				label.percent_visible = 1.0
				$Tween.stop_all()
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("textbox"):
				hide_textbox()
				emit_signal("startPhase")
				emit_signal("finished")
	
func hide_textbox():
	label.text = ""
	textbox_container.hide()
	change_state(State.READY)
	
func show_textbox():
	textbox_container.show()
	
func display_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	label.percent_visible = 0.0
	change_state(State.READING)
	show_textbox()
	$Tween.interpolate_property(label, "percent_visible", 0.0, 1.0, len(next_text) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
func queue_text(next_text, need_accept):
	if !prev_text == next_text:
		text_queue.push_back(next_text)
		prev_text = next_text
	if need_accept:
		button.visible = true
	else:
		button.visible = false


func _on_Tween_tween_all_completed():
	change_state(State.FINISHED)
	
func change_state(next_state):
	current_state = next_state

func _on_AcceptButton_pressed():
	print("you accepted")
	emit_signal("accepted")
