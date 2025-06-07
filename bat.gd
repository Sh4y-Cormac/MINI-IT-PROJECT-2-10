extends CharacterBody2D

class_name BatEnemy

const speed = 40
var dir: Vector2


var health = 100
var max_health = 100
var min_health = 0

var is_enemy_chase: bool

var player: CharacterBody2D

var dead: bool = false
var taking_damage: bool = false
var damage_to_deal = 10
var is_dealing_damage: bool = false

var knockback_force = 200
var is_roaming: bool = true


func _ready():
	is_enemy_chase = true
	
	
func _process(delta):
	move(delta)
	handle_animation()
	move_and_slide()

func move(delta):
	if !dead:
		if is_enemy_chase:
			player = Global.playerBody
			velocity = position.direction_to(player.position) * speed
			dir.x = abs(velocity.x) / velocity.x 
		elif !is_enemy_chase:
			velocity += dir * speed * delta
		is_roaming = true
	elif dead:
		velocity.x = 0
		velocity.y = 0

func _on_direction_timer_timeout() -> void:
	$DirectionTimer.wait_time = choose([1.5,2.0,3.5])
	if !is_enemy_chase:
		dir = choose([Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN])
		velocity.x = 0
		velocity.y = 0

func choose(array):
	array.shuffle()
	return array.front()

func handle_animation():
	var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
	if !dead and !taking_damage and !is_dealing_damage:
		animated_sprite_2d.play("fly")
		if dir.x == -1:
			animated_sprite_2d.flip_h = true
		elif dir.x == 1:
			animated_sprite_2d.flip_h = false
	elif !dead and taking_damage and !is_dealing_damage:
		animated_sprite_2d.play("hurt")
		await get_tree().create_timer(0.2).timeout
		taking_damage = false
	elif dead and is_roaming:
		is_roaming = false
		animated_sprite_2d.play("death")
		await get_tree().create_timer(1.0).timeout
		handle_death()

func handle_death():
	self.queue_free()
		
