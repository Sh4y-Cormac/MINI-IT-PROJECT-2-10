extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


const speed = 30
var is_enemy_chasing: bool
var dir: Vector2
var player: CharacterBody2D

var health = 80
var health_max = 0
var health_min = 0 
var dead: bool = false
var taking_damage: bool = false
var is_roaming: bool

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


func _on_robot_hitbox_area_entered(area: Area2D) -> void:
	if area == Global.playerDamageZone:
		var damage = Global.playerDamageAmount
		take_damage(damage)

func take_damage(damage):
	health -= damage
	taking_damage = true
	if health <0:
		health = 0
		dead = true
	print(str(self), "current health is ", health)
