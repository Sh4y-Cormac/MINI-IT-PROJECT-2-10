class_name Enemy extends Area2D

signal kill(gold_earned)

@export var speed = 150
@export var hp = 1
@export var gold_earned = 1

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

func damage(amount):
	hp -= amount
	if hp <= 0:
		kill.emit(gold_earned)
		destroyed()
	
