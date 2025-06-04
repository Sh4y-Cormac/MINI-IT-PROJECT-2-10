extends Node2D

var correct_answer := "yellow"
var bridge_opened := false

func open_bridge(answer: String) -> void:
	if bridge_opened:
		return

	if answer == correct_answer:
		print("Correct! Opening bridge.")
		$bridge_city/AnimationPlayer.play("fall")
		bridge_opened = true
	else:
		print("Wrong answer!") 

func _on_red_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		open_bridge("red")


func _on_green_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		open_bridge("green")


func _on_yellow_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		open_bridge("yellow")
