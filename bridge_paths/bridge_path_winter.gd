extends Node2D

var correct_answer := "key_blue"
var bridge_opened := false

func open_bridge(answer: String) -> void:
	if bridge_opened:
		return

	if answer == correct_answer:
		print("Correct! Opening bridge.")
		$bridge_winter/AnimationPlayer.play("fall")
		bridge_opened = true
	else:
		print("Wrong answer!") 


func _on_key_yellow_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		open_bridge("key_yellow")


func _on_key_blue_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		open_bridge("key_blue")


func _on_key_green_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		open_bridge("key_green")
