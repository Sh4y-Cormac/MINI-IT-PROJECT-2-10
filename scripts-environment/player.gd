extends CharacterBody2D


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

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or is_on_wall()):
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
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
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
	
	move_and_slide()
