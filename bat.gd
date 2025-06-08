extends CharacterBody2D

class_name BatEnemy

const speed = 40
var dir: Vector2


var health = 100
var max_health = 100
var min_health = 0

var is_enemy_chase: bool

var player: CharacterBody2D

func _ready():
	is_enemy_chase = false
	
	
func _process(delta):
	move(delta)
	handle_animation()

func move(delta):
	if is_enemy_chase:
		player = Global.playerBody
		velocity = position.direction_to(player.position) * speed
		dir.x = abs(velocity.x) / velocity.x 
	elif !is_enemy_chase:
		velocity += dir * speed * delta
	move_and_slide()

func _on_direction_timer_timeout() -> void:
	$DirectionTimer.wait_time = choose([0.5,0.8])
	if !is_enemy_chase:
		dir = choose([Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN])

func choose(array):
	array.shuffle()
	return array.front()

func handle_animation():
	var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
	animated_sprite_2d.play("fly")
	if dir.x == -1:
		animated_sprite_2d.flip_h = true
	elif dir.x == 1:
		animated_sprite_2d.flip_h = false
