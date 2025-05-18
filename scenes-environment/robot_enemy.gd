extends CharacterBody2D


const speed = 30
var dir: Vector2

var is_enemy_chasing: bool

func _ready() -> void:
	is_enemy_chasing = false
	
func _process(delta: float) -> void:
	move(delta)

func move(delta):
	if !is_enemy_chasing:
		velocity += dir * speed * delta
	move_and_slide()

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([1.0, 1.5, 2.0])
	if !is_enemy_chasing:
		dir = choose([Vector2.RIGHT, Vector2.LEFT])
		print(dir)

func choose(array):
	array.shuffle()
	return array.front()
