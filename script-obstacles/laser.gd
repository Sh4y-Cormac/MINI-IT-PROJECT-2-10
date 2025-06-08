extends Node2D

@onready var ray = $RayCast2D
@onready var line = $Line2D
@onready var laser_sfx = $laser_sfx
@onready var lasertimer = $laserkill/Timer
	
func _ready():
	hide_laser()
	_start_laser_loop()
	lasertimer.wait_time = 3.0 

func _start_laser_loop():
	randomize()
	_laser_cycle()

func _laser_cycle():

	await get_tree().create_timer(randf_range(2.0, 4.0)).timeout
	show_laser()
	check_for_hit()
	laser_sfx.play()

	await get_tree().create_timer(1.0).timeout
	hide_laser()
	_laser_cycle()

func show_laser():
	ray.enabled = true
	line.visible = true
	$laserkill.monitoring = true

func hide_laser():
	ray.enabled = false
	line.visible = false
	$laserkill.monitoring = false

func check_for_hit():
	if ray.is_colliding():
		var hit = ray.get_collider()
		if hit and hit.name == "player":
			var col = hit.get_node_or_null("CollisionShape2D")
			if col:
				col.disabled = true 
			lasertimer.start()
			
func _on_laserkill_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player":
		var col = body.get_node_or_null("CollisionShape2D")
		if col:
			col.queue_free()
		lasertimer.start()
		

func _on_timer_timeout() -> void:
		Engine.time_scale = 1.0
		get_tree().reload_current_scene()
