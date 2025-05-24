class_name Enemy extends Area2D

@export var speed = 150

func _physics_process(delta):
	global_position.y += speed * delta

func destroyed():
	queue_free()


func _on_body_entered(body):
	if body is SpaceShip:
		body.destroyed()
		destroyed()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
