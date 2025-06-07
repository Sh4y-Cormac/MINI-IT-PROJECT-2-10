extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$"../Animations/ShopAnimation".play("Shop_Show")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		$"../Animations/ShopAnimation".play("Shop_Hide")
