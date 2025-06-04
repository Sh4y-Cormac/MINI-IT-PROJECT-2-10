extends Node2D

var correct_answer := "sun"
var bridge_opened := false

func open_bridge(answer: String) -> void:
	if bridge_opened:
		return

	if answer == correct_answer:
		print("Correct! Opening bridge.")
		$bridge/AnimationPlayer.play("fall")
		bridge_opened = true
	else:
		print("Wrong answer!")
		
func _on_sun_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		open_bridge("sun")


func _on_moon_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		open_bridge("moon")


func _on_saturn_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		open_bridge("saturn")
