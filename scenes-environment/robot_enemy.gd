extends CharacterBody2D

class_name RobotEnemy

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var robot_deal_damage_area: Area2D = $RobotDealDamageArea


const speed = 30
var is_enemy_chasing: bool
var dir: Vector2
var player: CharacterBody2D
var is_dealing_damage: bool = false

var health = 200
var health_max = 200
var health_min = 0 
const gravity = 900 

var dead: bool = false
var taking_damage: bool = false
var is_roaming: bool
var damage_to_deal = 20
var knockback_force = -200
var droppedGold = 100

func _ready() -> void:
	is_enemy_chasing = true
	difficulty_health_increase()
	
func _process(delta: float) -> void:
	Global.robotDamageAmount = damage_to_deal
	Global.robotDamageZone = robot_deal_damage_area
	player = Global.playerBody
	
	if Global.playerAlive:
		is_enemy_chasing = true
	if !Global.playerAlive:
		is_enemy_chasing = false
	
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
		
	move(delta)
	animation()
	move_and_slide()

func move(delta):
	if !dead:
		if !is_enemy_chasing:
			velocity += dir * speed * delta
		elif is_enemy_chasing and !taking_damage:
			var dir_to_player = position.direction_to(player.position) * speed
			velocity.x = dir_to_player.x
			dir.x = abs(velocity.x) / velocity.x
		elif taking_damage:
			var knockback_dir = position.direction_to(player.position) * knockback_force
			velocity.x = knockback_dir.x
		is_roaming = true
	elif dead:
		velocity.x = 0


func animation():
	if !dead and !taking_damage and !is_dealing_damage:
		animated_sprite.play("move")
		if dir.x == 1:
			animated_sprite.flip_h = true
		elif dir.x == -1:
			animated_sprite.flip_h = false
	elif !dead and taking_damage and !is_dealing_damage:
		animated_sprite.play("hurt")
		await get_tree().create_timer(0.4).timeout
		taking_damage = false
	elif dead and is_roaming:
		is_roaming = false
		animated_sprite.play("death")
		await get_tree().create_timer(0.2).timeout
		handle_death()
	elif !dead and is_dealing_damage:
		animated_sprite.play("attack")

func handle_death():
	Global.playerGold += droppedGold
	give_random_card()
	
	
func give_random_card():
	if Global.available_buff_cards.is_empty():
		return
	
	var random_index = randi() % Global.available_buff_cards.size()
	var random_card = Global.available_buff_cards[random_index]
	
	BuffManager.add_card(random_card)
	print("Card given:", random_card.name)
	
	var cutscene_scene = preload("res://cutscene/cutscene_2_outro.tscn")
	get_tree().change_scene_to_packed(cutscene_scene)
	self.queue_free()
	
func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([1.0, 1.5, 2.0])
	if !is_enemy_chasing:
		dir = choose([Vector2.RIGHT, Vector2.LEFT])
		print(dir)

func choose(array):
	array.shuffle()
	return array.front()

#handles taking damage from player
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
	

func _on_robot_deal_damage_area_area_entered(area: Area2D) -> void:
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
