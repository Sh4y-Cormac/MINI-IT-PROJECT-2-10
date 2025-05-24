extends Control

@onready var spawn_position = $SpawnPoint
@onready var laser_container = $LaserContainer

var SpaceShip = null

func _ready():
	SpaceShip = get_tree().get_first_node_in_group("spaceship")
	SpaceShip.global_position = spawn_position.global_position
	SpaceShip.laser_shot.connect(_on_player_laser_shot)

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
 
