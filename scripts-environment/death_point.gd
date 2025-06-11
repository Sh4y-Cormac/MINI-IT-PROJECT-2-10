extends Area2D

@onready var timer = $Timer
var spike_damage = 10

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if body.has_method("take_damage"):
			body.take_damage(spike_damage)
	print("You died")
	timer.start()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
