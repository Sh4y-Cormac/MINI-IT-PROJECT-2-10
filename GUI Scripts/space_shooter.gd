extends Control

@export var enemyscenes: Array[PackedScene] = []

@onready var spawn_position = $SpawnPoint
@onready var laser_container = $LaserContainer
@onready var spawnrate = $EnemySpawnRate
@onready var enemy_container = $EnemyContainer
@onready var HUD = $"UI layer/HUD"
@onready var GameOverScreen = $"UI layer/SpaceShipGameOver"
@onready var background = $ParallaxBackground

@onready var laser_sound = $SFX/LaserShootingSound
@onready var explosion_sound = $SFX/ExplosionSound
@onready var hit_sound = $SFX/HitSound

var SpaceShip = null
var score := 0:
	set(value):
		score = value
		HUD.score = score
var scroll_speed = 100

func _ready():
	score = 0
	SpaceShip = get_tree().get_first_node_in_group("spaceship")
	SpaceShip.global_position = spawn_position.global_position
	SpaceShip.laser_shot.connect(_on_player_laser_shot)
	SpaceShip.killed.connect(on_player_killed)

func _process(delta):
	if spawnrate.wait_time > 0.5:
		spawnrate.wait_time -= delta * 0.05
		
	elif spawnrate.wait_time < 0.5:
		spawnrate.wait_time = 0.5
	
	background.scroll_offset.y += delta * scroll_speed
	if background.scroll_offset.y > 500:
		background.scroll_offset.y = 0

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
	laser_sound.play()

func _on_enemy_spawn_rate_timeout() -> void:
	var enemy = enemyscenes.pick_random().instantiate()
	enemy.global_position = Vector2(randf_range(50, 400), 60)
	enemy.kill.connect(on_enemy_killed)
	enemy.hit.connect(on_enemy_hit)
	enemy_container.add_child(enemy)

func on_enemy_killed(gold_earned):
	hit_sound.play()
	score += gold_earned


func on_enemy_hit():
	hit_sound.play()


func on_player_killed():
	explosion_sound.play()
	GameOverScreen.set_score(score)
	await get_tree().create_timer(1).timeout
	GameOverScreen.visible = true
