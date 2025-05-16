extends CharacterBody2D

@export var speed: float = 100.0
@export var max_distance: float = 200.0

var direction := 1
var start_position := Vector2.ZERO

func _ready():
	start_position = get_viewport_rect().size / 2 
	global_position = start_position

func _physics_process(delta):
   
	velocity.x = speed * direction
	move_and_slide()

	if abs(global_position.x - start_position.x) >= max_distance:
		direction *= -1

	$Sprite2D.rotation += direction * speed * delta / 50.0
