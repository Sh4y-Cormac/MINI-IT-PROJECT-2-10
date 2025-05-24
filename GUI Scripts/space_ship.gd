extends CharacterBody2D

@export var speed = 300
@onready var guns = $PlayerShip/Guns

signal laser_shot(laser_scene, location)
var laser_scene = preload("res://GUI Scenes/shiplaser.tscn")


func _process(delta):
	if Input.is_action_just_pressed("Ship_Shoot"):
		shoot()

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("Ship_Left", 
	"Ship_Right"), Input.get_axis("Ship_Up", "Ship_Down"))
	
	velocity = direction * speed
	move_and_slide()

func shoot():
	laser_shot.emit(laser_scene, guns.global_position)
