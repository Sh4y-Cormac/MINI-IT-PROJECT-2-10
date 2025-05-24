class_name SpaceShip extends CharacterBody2D

@export var speed = 300
@onready var guns = $PlayerShip/Guns

signal laser_shot(laser_scene, location)
var laser_scene = preload("res://GUI Scenes/shiplaser.tscn")
var cooldown := false


func _process(delta):
	if Input.is_action_pressed("Ship_Shoot"):
		if !cooldown:
			cooldown = true
			shoot()
			await get_tree().create_timer(0.25).timeout
			cooldown = false

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("Ship_Left", 
	"Ship_Right"), Input.get_axis("Ship_Up", "Ship_Down"))
	
	velocity = direction * speed
	move_and_slide()

func shoot():
	laser_shot.emit(laser_scene, guns.global_position)

func destroyed():
	queue_free()
