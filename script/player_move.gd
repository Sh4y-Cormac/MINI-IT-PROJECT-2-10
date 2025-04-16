extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var jump_count = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprites = $AnimatedSprite2D

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

	# Get the input direction : -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# flip sprite
	if direction > 0:
		animated_sprites.flip_h = false
	elif direction < 0:
		animated_sprites.flip_h = true
		
	# Play animation
	if is_on_floor():
		if direction == 0:
			animated_sprites.play("idle")
		else:
			animated_sprites.play("run")
	else:
		animated_sprites.play("jump")
		
	# apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
