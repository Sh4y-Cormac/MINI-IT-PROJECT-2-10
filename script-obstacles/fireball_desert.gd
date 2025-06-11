extends Node2D

@export var damage := 10 
@export var fall_speed := 400  

var fireball_damage = 10

func _physics_process(delta):
	position.y += fall_speed * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if body.has_method("take_damage"):
			body.take_damage(fireball_damage)
	
		
