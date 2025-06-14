extends CharacterBody2D

class_name SlimeEnemy

const speed = 45
var is_enemy_chase: bool = true

var health = 400
var health_max = 400
var health_min = 0

var dead: bool = false
var taking_damage: bool = false
var damage_to_deal = 30
var is_dealing_damage: bool = false

var dir: Vector2
const gravity = 900 
var knockback_force = -200
var is_roaming: bool = false

var player: CharacterBody2D
var player_in_area = false

var droppedGold = 500

func _ready() -> void:
	difficulty_health_increase()


func _process(delta: float) -> void:
	
	Global.slimeDamageAmount = damage_to_deal
	Global.slimeDamageZone = $SlimeDealDamageArea
	player = Global.playerBody
	
	if Global.playerAlive:
		is_enemy_chase = true
	if !Global.playerAlive:
		is_enemy_chase = false
		
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
	move(delta)
	handle_animation()
	move_and_slide()

func move(delta):
	if !dead:
		if !is_enemy_chase:
			velocity += dir * speed * delta
		elif is_enemy_chase and !taking_damage:
			var dir_to_player = position.direction_to(player.position) * speed
			velocity.x = dir_to_player.x
			dir.x = abs(velocity.x) / velocity.x
		elif taking_damage:
			var knockback_dir = position.direction_to(player.position) * knockback_force
			velocity.x = knockback_dir.x
		is_roaming = true
	elif dead:
		velocity.x = 0

func handle_animation():
	var animated_sprite = $AnimatedSprite2D
	if !dead and !taking_damage and !is_dealing_damage:
		animated_sprite.play("move")
		if dir.x == -1:
			animated_sprite.flip_h = true
		elif dir.x == 1:
			animated_sprite.flip_h = false
	elif !dead and taking_damage and !is_dealing_damage:
		animated_sprite.play("hurt")
		await get_tree().create_timer(0.2).timeout
		taking_damage = false
	elif dead and is_roaming:
		is_roaming = false
		animated_sprite.play("death")
		await get_tree().create_timer(0.2).timeout
		handle_death()
	elif !dead and is_dealing_damage:
		animated_sprite.play("deal_damage")
		

func handle_death():
	Global.playerGold += droppedGold
	self.queue_free()
	
func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([1.0,1.5,2.0])
	if !is_enemy_chase:
		dir = choose([Vector2.RIGHT, Vector2.LEFT])
		velocity.x = 0
	
func choose(array):
	array.shuffle()
	return array.front()


func _on_slime_hitbox_area_entered(area: Area2D) -> void:
	var damage = Global.playerDamageAmount
	if area == Global.playerDamageZone:
		take_damage(damage)
		
		
func take_damage(damage):
	health -= damage
	taking_damage = true
	if health <= health_min:
		health = health_min
		dead = true

func _on_slime_deal_damage_area_area_entered(area: Area2D) -> void:
	var animated_sprite = $AnimatedSprite2D
	if !dead:
		if area == Global.playerHitbox:
			is_dealing_damage = true
			await get_tree().create_timer(1).timeout
			is_dealing_damage = false

func difficulty_health_increase():
	var difficulty = Global.difficulty
	health = health * difficulty
	health_max = health_max * difficulty
