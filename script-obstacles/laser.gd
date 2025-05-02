extends Node2D

@onready var ray = $RayCast2D
@onready var line = $Line2D

func _ready():
	hide_laser()
	_start_laser_loop()

func _start_laser_loop():
	randomize()
	_laser_cycle()

func _laser_cycle():

	await get_tree().create_timer(randf_range(2.0, 4.0)).timeout
	show_laser()
	check_for_hit()

	await get_tree().create_timer(1.0).timeout
	hide_laser()
	_laser_cycle()

func show_laser():
	ray.enabled = true
	line.visible = true

func hide_laser():
	ray.enabled = false
	line.visible = false

func check_for_hit():
	if ray.is_colliding():
		var hit = ray.get_collider()
		if hit and hit.name == "Player":  
			hit.take_damage()  
