extends Node

var speed := 0.0

func _physics_process(delta):
	speed += 1000 * delta  
	get_parent().position.y += speed * delta
