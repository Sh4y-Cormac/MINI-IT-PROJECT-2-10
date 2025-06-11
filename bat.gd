extends CharacterBody2D

class_name BatEnemy

const speed = 40
var dir: Vector2


var health = 100
var health_max = 100
var health_min = 0

var dead: bool = false
var taking_damage: bool = false
var damage_to_deal: int = 10
var is_dealing_damage: bool = false

var is_enemy_chase: bool

var player: CharacterBody2D
var player_in_area: bool = false


var knockback_force = -200
var is_roaming: bool = true

func _ready():
	is_enemy_chase = true
	
	
	
func _process(delta):
	player = Global.playerBody
	Global.batDamageAmount = damage_to_deal
	Global.batDamageZone = $BatDealDamageArea
	move(delta)
	handle_animation()
	move_and_slide()

func move(delta):
	if !dead: 
		if !is_enemy_chase:
			velocity += dir * speed * delta
		elif is_enemy_chase and !taking_damage:
			velocity = position.direction_to(player.position) * speed
			dir.x = abs(velocity.x) / velocity.x
		elif taking_damage:
			var knockback_dir = position.direction_to(player.position) * knockback_force
			velocity.x = knockback_dir.x
		is_roaming = true
	

func _on_direction_timer_timeout() -> void:
	$DirectionTimer.wait_time = choose([0.5,0.8])
	if !is_enemy_chase:
		dir = choose([Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN])

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
		await get_tree().create_timer(1).timeout
		handle_death()
	elif !dead and is_dealing_damage:
		animated_sprite_2d.play("attack")
		
func handle_death():
	self.queue_free()


func _on_bat_hitbox_area_entered(area: Area2D) -> void:
	var damage = Global.playerDamageAmount
	if area == Global.playerDamageZone:
		take_damage(damage)

func take_damage(damage):
	health -= damage
	taking_damage = true
	if health <= health_min:
		health = health_min
		dead = true
		print("the bat has died")
		
func _on_bat_deal_damage_area_area_entered(area: Area2D) -> void:
	if area == Global.playerHitbox:
		is_dealing_damage = true
		await get_tree().create_timer(1.0).timeout
		is_dealing_damage = false
