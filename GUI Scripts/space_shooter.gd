extends Control

@export var enemyscenes: Array[PackedScene] = []

@onready var spawn_position = $SpawnPoint
@onready var laser_container = $LaserContainer
@onready var spawnrate = $EnemySpawnRate
@onready var enemy_container = $EnemyContainer

var SpaceShip = null

func _ready():
	SpaceShip = get_tree().get_first_node_in_group("spaceship")
	SpaceShip.global_position = spawn_position.global_position
	SpaceShip.laser_shot.connect(_on_player_laser_shot)

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
 

func _on_enemy_spawn_rate_timeout() -> void:
	var enemy = enemyscenes.pick_random().instantiate()
	enemy.global_position = Vector2(300, 60)
	enemy_container.add_child(enemy)
