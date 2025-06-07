extends CharacterBody2D

class_name Player

@export var walk_speed = 200.0
@export var run_speed = 400.0
@export_range(0,1) var acceleration = 0.2
@export_range(0,1) var deceleration = 0.2

@export var jump_force = -500.0
@export_range(0,1) var decelerate_on_jump_release = 0.5

@export var dash_speed = 1000
@export var dash_max_distance = 150.0
@export var dash_curve : Curve
@export var dash_cooldown = 1.0

var is_dashing = false
var dash_start_position = 0
var dash_direction = 0
var dash_timer = 0

var isAttacking = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var deal_damage_zone: Area2D = $DealDamageZone

var jump_count = 0

var attack_type: String
var current_attack: bool 

var health = Global.playerHealth
var health_max = 100
var health_min = 0
var can_take_damage: bool
var dead: bool 

var skin = Global.playerSkin

var deathAnim: String
var idleAnim: String
var jumpAnim: String
var longswordAttackAnim: String
var runAnim: String
var shortswordAttackAnim: String

func _ready() -> void:
	Global.playerBody = self
	Global.playerAlive = true
	
	print(skin)
	select_skin(skin)
	current_attack = false
	dead = false
	can_take_damage = true

func _physics_process(delta: float) -> void:
	Global.playerDamageZone = deal_damage_zone
	Global.playerHitbox = $PlayerHitbox
	 
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump_count = 0
	#test if the player is not dead
	if !dead: 

		# Handle jump.
		if Input.is_action_just_pressed("jump") and (jump_count < 2 or is_on_wall()):
			jump_count += 1
			velocity.y = jump_force
	
		if Input.is_action_just_released("jump") and velocity.y < 0:
			velocity.y *= decelerate_on_jump_release
	
	#handles running
		var speed
		if Input.is_action_pressed("run"):
			speed = run_speed
		else:
			speed = walk_speed

	# Get the input direction and handle the movement/deceleration.
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
		else:
			velocity.x = move_toward(velocity.x, 0, walk_speed * deceleration)
	
	#dash mechanic
		if Input.is_action_just_pressed("dash") and direction and not is_dashing and dash_timer <= 0:
			is_dashing = true
			dash_start_position = position.x
			dash_direction = direction
			dash_timer = dash_cooldown
	
	#performs actual dash
		if is_dashing:
			var current_distance = abs(position.x - dash_start_position)
			if current_distance >= dash_max_distance or is_on_wall():
				is_dashing = false
			else:
				velocity.x = dash_direction * dash_speed * dash_curve.sample(current_distance/dash_max_distance)
				velocity.y = 0
	
	#reduces dash timer
		if dash_timer > 0:
			dash_timer -= delta
	
		if !current_attack:
			if Input.is_action_just_pressed("left_mouse") or Input.is_action_just_pressed("right_mouse"):
				current_attack = true
				if Input.is_action_just_pressed("left_mouse"):
					attack_type = "shortsword"
				elif Input.is_action_just_pressed("right_mouse"):
					attack_type = "longsword"
			
				set_damage(attack_type)
				handle_attack_animation(attack_type)
			
		handle_movement_animation(direction)
		check_hitbox()	
	move_and_slide()

func select_skin(skin): #selects the skin based on the input of the customize button
	if skin == 0:
		runAnim = str("run_0")
		idleAnim = str("idle_0")
		jumpAnim = str("jump_0")
		longswordAttackAnim = str("longsword_attack")
		shortswordAttackAnim = str("shortsword_attack")
		deathAnim = str("death_0")
	elif skin == 1:
		runAnim = str("run_1")
		idleAnim = str("idle_1")
		jumpAnim = str("jump_1")
		longswordAttackAnim = str("longsword_attack")
		shortswordAttackAnim = str("shortsword_attack")
		deathAnim = str("death_1")
	elif skin == 2:
		runAnim = str("run_2")
		idleAnim = str("idle_2")
		jumpAnim = str("jump_2")
		longswordAttackAnim = str("longsword_attack")
		shortswordAttackAnim = str("shortsword_attack")
		deathAnim = str("death_2")
	elif skin == 3:
		runAnim = str("run_3")
		idleAnim = str("idle_3")
		jumpAnim = str("jump_3")
		longswordAttackAnim = str("longsword_attack")
		shortswordAttackAnim = str("shortsword_attack")
		deathAnim = str("death_3")
	elif skin == 4:
		runAnim = str("run_4")
		idleAnim = str("idle_4")
		jumpAnim = str("jump_4")
		longswordAttackAnim = str("longsword_attack")
		shortswordAttackAnim = str("shortsword_attack")
		deathAnim = str("death_4")
	else:
		print("skin error detected")


#checks hitboxes for ALL enemies, refer to this block to add new enemies' damage values
func check_hitbox():
	var hitbox_areas = $PlayerHitbox.get_overlapping_areas()
	var damage: int
	var strikeFrame: float ##the exact frame of the strike
	if hitbox_areas:
		var hitbox = hitbox_areas.front()
		if hitbox.get_parent() is RobotEnemy:
			damage = Global.robotDamageAmount
		elif hitbox.get_parent() is GolemBoss:
			damage = Global.golemDamageAmount
			strikeFrame = float(0.4)
			
	if can_take_damage:
		take_damage(damage, strikeFrame)

func take_damage(damage, strikeFrame):
	if damage != 0:
		if health > 0:
			health -= damage
			print("player health :", health)
			if health <= 0:
				health = 0
				dead = true
				handle_death_animation()
			take_damage_cooldown(3.0)

## Runs code when the player dies
func handle_death_animation():
	print("player has died!")
	$CollisionShape2D.position.y = 5
	animated_sprite.play(deathAnim)
	await get_tree().create_timer(0.6).timeout
	$Camera2D.zoom.x = 4
	$Camera2D.zoom.y = 4
	await get_tree().create_timer(3.0).timeout
	Global.playerAlive = false
	await get_tree().create_timer(0.5).timeout
	self.queue_free()


func take_damage_cooldown(wait_time):
	can_take_damage = false
	await get_tree().create_timer(wait_time).timeout
	can_take_damage = true
		

## handles movement animations (running,jumping,idling)
func handle_movement_animation(direction):
	if is_on_floor() and !current_attack:
		if !velocity:
			animated_sprite.play(idleAnim)
		if velocity:
			animated_sprite.play(runAnim)
			toggle_flip_sprite(direction)
	elif !is_on_floor() and !current_attack:
		animated_sprite.play(jumpAnim)
		toggle_flip_sprite(direction)

func toggle_flip_sprite(direction):
	if direction == 1:
		animated_sprite.flip_h = false
		deal_damage_zone.scale.x = 1
	if direction == -1:
		animated_sprite.flip_h = true
		deal_damage_zone.scale.x = -1

#when making attack anims, make sure to put _attack behind it.
func handle_attack_animation(attack_type):
	if current_attack:
		var skinIndex = grab_skin()
		var skinNumber = str("_", skinIndex)
		print(skinNumber)
		var animation = str(attack_type, "_attack", skinNumber)
		animated_sprite.play(animation)
		toggle_damage_collisions(attack_type)

#turns on damage hitbox for when we are attacking
#also changes into a bigger hitbox for longsword attack. 
func toggle_damage_collisions(attack_type):
	var damage_zone_collision  = deal_damage_zone.get_node("CollisionShape2D")
	var origin: Vector2 = damage_zone_collision.position
	var originSize: Vector2 = damage_zone_collision.shape.extents
	var wait_time: float
	if attack_type == "shortsword":
		wait_time = 0.4
	elif attack_type == "longsword":
		damage_zone_collision.position = Vector2(30.0,0.0)  # size of longsword collision
		damage_zone_collision.shape.extents = Vector2(20.0,35.0) # size of longsword collision
		wait_time = 0.7
	damage_zone_collision.disabled = false
	await get_tree().create_timer(wait_time).timeout
	damage_zone_collision.position = origin
	damage_zone_collision.shape.extents = originSize
	damage_zone_collision.disabled = true
		
func _on_animated_sprite_2d_animation_finished() -> void:
	current_attack = false

func set_damage(attack_type):
	var current_damage_to_deal: int
	if attack_type == "shortsword":
		current_damage_to_deal = 10
	elif attack_type == "longsword":
		current_damage_to_deal = 25
	Global.playerDamageAmount = current_damage_to_deal

#this function's whole purpose is to return the 'index' of the skin so that i know which attack anim to use because the attack anim is different for each skin
func grab_skin():
	var skin = Global.playerSkin
	return skin
