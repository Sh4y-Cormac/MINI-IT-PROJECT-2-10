extends StaticBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("down"):
		collision_shape_2d.disabled = true
		timer.start()
	
func _on_timer_timeout() -> void:
	collision_shape_2d.disabled = false
