#all of this code will be the base code for the charcter..we have to change it after all the neccesary sprites are ready to use
#the sprites that needs additional lines of code will be implimented when the sprites are available.. like healing animation, getting a wild card and etc.
#all of these codes are ONLY the base, at some point some lines will be changed if there is a more optimal way to code it 
#also all this code is a carbon copy of what Devworm did...FOR NOW!!
extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var gravity = 600


var weapon_equip = bool

func _ready():
	weapon_equip = false

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	handle_movement_animation(direction)

func handle_movement_animation(dir):#this will be the animations that for character.. for now untill we know what the main animations are
	if !weapon_equip:
		if is_on_floor:
			if !velocity:
				animated_sprite.play("idle")#I think this is gonna be changed to the shorter sword animations
			if velocity:
				animated_sprite.play("run")
				toggle_flip_sprite(dir)
			elif !is_on_floor:
				animated_sprite.play("fall")
	if weapon_equip:
		if is_on_floor:
			if !velocity:
				animated_sprite.play("weapon_idle")#And this one will be the longer sword animation
			if velocity:
				animated_sprite.play("Weapon_run")
				toggle_flip_sprite(dir)
			elif !is_on_floor:
				animated_sprite.play("weapon_fall")
		

func toggle_flip_sprite(dir):
	if dir == 1:
		animated_sprite.flip_h = false
	if dir == -1:
		animated_sprite.flip_h = true 	

	
