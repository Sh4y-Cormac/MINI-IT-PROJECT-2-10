extends Area2D

@export var bridge_path: NodePath  

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":  
		var bridge = get_node(bridge_path)
		bridge.get_node("bridge_city/AnimationPlayer").play("fall")
		queue_free() 
