extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


const speed = 30
var is_enemy_chasing: bool

var health = 80
var health_max = 0
var health_min = 0 
var dead: bool = false
var taking_damage: bool = false

var dir: Vector2
var player: CharacterBody2D

var is_enemy_attacking: bool

func _ready() -> void:
	is_enemy_chasing = true
	
func _process(delta: float) -> void:
	move(delta)
	animation()

func move(delta):
	if is_enemy_chasing:
		player = Global.playerBody
		velocity = position.direction_to(player.position) * speed
		dir.x = abs(velocity.x) / velocity.x
	if !is_enemy_chasing:
		velocity += dir * speed * delta
	move_and_slide()

func animation():
	animated_sprite.play("move")
	if dir.x == 1:
		animated_sprite.flip_h = true
	elif dir.x == -1:
		animated_sprite.flip_h = false

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([1.0, 1.5, 2.0])
	if !is_enemy_chasing:
		dir = choose([Vector2.RIGHT, Vector2.LEFT])
		print(dir)

func choose(array):
	array.shuffle()
	return array.front()
