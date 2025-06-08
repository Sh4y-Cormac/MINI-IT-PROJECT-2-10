extends Node2D

@export var damage := 100
@export var fall_speed := 400  
@export var gravity := 1200
@onready var fireballtimer = $Area2D/Timer

var falling_player: CharacterBody2D = null
var fall_velocity := 0.0

func _physics_process(delta):
	position.y += fall_speed * delta

	if falling_player:
		fall_velocity += gravity * delta
		falling_player.position.y += fall_velocity * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var col = body.get_node_or_null("CollisionShape2D")
		if col:
			col.disabled = true  # Remove collision

		if body.has_method("set_physics_process"):
			body.set_physics_process(false)

		falling_player = body
		fall_velocity = 0
		
		if body.name == "player":
			Global.take_damage()
		
		fireballtimer.start()
		
func _on_timer_timeout() -> void:
		get_tree().reload_current_scene()
