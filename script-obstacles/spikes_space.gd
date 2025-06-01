extends Node2D


func _on_spike_killzone_body_entered(body: Node2D) -> void:
	if body.name == "player":
		get_tree().reload_current_scene()
