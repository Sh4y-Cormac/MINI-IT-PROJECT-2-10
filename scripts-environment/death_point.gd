extends Area2D

@onready var timer = $Timer
var has_triggered := false

func _ready():
	print("KillZone ready")

func _on_body_entered(body: Node2D) -> void:
	print("You died")
	timer.start()


func _on_timer_timeout() -> void:
	print("Timer finished")
	get_tree().reload_current_scene()
