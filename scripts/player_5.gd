extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -350.0
var jump_count = 0

const DASH_SPEED = 500.0
var dashing = false 
var can_dash = true

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump_count = 0


	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		jump_count += 1
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("dash") and can_dash:
		dashing = true
		can_dash = false
		$dash_timer.start()
		$dash_again_timer.start()

# Get input direction : -1, 0, 1
	var direction = 0
	if Input.is_action_pressed("move_right"):
		direction = 1

	if direction:
		if dashing:
			velocity.x = direction * DASH_SPEED
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction > 0:
		animated_sprite.flip_h = false

	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Play animation
	if is_on_floor():
		if not Input.is_action_pressed("move_right"):
			animated_sprite.play("player5_idle")
		else:
			animated_sprite.play("player5_run")
	else:
		animated_sprite.play("player5_jump")

	move_and_slide()


func _on_dash_timer_timeout() -> void:
	dashing = false


func _on_dash_again_timer_timeout() -> void:
	can_dash = true
