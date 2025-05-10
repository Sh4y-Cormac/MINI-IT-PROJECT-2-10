extends Area2D

@onready var timer = $Timer
var fallen_body: Node2D = null

func _on_body_entered(body: Node2D) -> void:
	print("You died")
	timer.start()

func _on_timer_timeout() -> void:
	print("Timer finished")
	get_tree().reload_current_scene() 
