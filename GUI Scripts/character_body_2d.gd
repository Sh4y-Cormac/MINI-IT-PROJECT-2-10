extends CharacterBody2D

var scroll = false
var of = Vector2(0, 0)

func _physics_process(delta):
	var mouse_pos = get_global_mouse_position() - of
	if scroll :
		$"../Options Menu/Panel/Node2D".position.y = mouse_pos.y
	
	move_and_slide()
	if Input.is_action_pressed("click"):
		scroll = true
		of = get_global_mouse_position() - $"../Options Menu/Panel/Node2D".position

	else: 
		scroll = false
