extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("HELLO")
		get_node($"../CanvasLayer/Shop GUI").play("TransIn")
