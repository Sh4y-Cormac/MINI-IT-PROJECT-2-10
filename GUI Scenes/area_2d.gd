extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Shop.mode = Shop.MODE.ON

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		Shop.mode = Shop.MODE.OFF
