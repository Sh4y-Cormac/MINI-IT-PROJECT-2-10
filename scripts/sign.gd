extends Node2D



func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	$Label.show()


func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	$Label.hide()
	
