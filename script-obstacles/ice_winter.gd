extends Node2D

@onready var icetimer = $Sprite2D/ice_kill/ice_timer
var icewater_damage = 10

func _on_ice_kill_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if body.has_method("take_damage"):
			body.take_damage(icewater_damage)
		icetimer.start()


func _on_ice_timer_timeout() -> void:
		Engine.time_scale = 1.0
		get_tree().reload_current_scene()  
