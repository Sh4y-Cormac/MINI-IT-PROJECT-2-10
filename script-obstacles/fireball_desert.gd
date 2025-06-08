extends Node2D

@export var damage := 100
@export var fall_speed := 400  
@export var gravity := 1200

var falling_player: CharacterBody2D = null
var fall_velocity := 0.0
var spike_damage = 10

func _physics_process(delta):
	position.y += fall_speed * delta

	if falling_player:
		fall_velocity += gravity * delta
		falling_player.position.y += fall_velocity * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if body.has_method("take_damage"):
			body.take_damage(damage, 0)

	falling_player = body
	fall_velocity = 0
	
		
