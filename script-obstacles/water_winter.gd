extends Node2D

@onready var watertimer = $Sprite2D/waterkill/Timer
var waterwinter_damage = 10

func _on_waterkill_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if body.has_method("take_damage"):
			body.take_damage(waterwinter_damage)
		watertimer.start()

func _on_timer_timeout() -> void:
		Engine.time_scale = 1.0
		get_tree().reload_current_scene()  
		
