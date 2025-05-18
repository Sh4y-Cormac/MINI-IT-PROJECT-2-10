extends CharacterBody2D

@export var speed: float = 100.0
@export var max_distance: float = 200.0

var direction := 1
var start_position := Vector2.ZERO
var can_move := true
var is_blocked_by_player := false

func _ready():
	start_position = global_position 

func _physics_process(delta):
	if can_move:
		var motion = Vector2(speed * direction, 0) * delta
		var collision = move_and_collide(motion)

		if collision:
			if collision.get_collider().name == "player":
				can_move = false
				is_blocked_by_player = true
			else:
				direction *= -1

	else:
		var test_motion = Vector2(speed * direction, 0) * delta
		var test_collision = move_and_collide(test_motion, true)
		
		if test_collision == null or test_collision.get_collider().name != "player":
			can_move = true
			is_blocked_by_player = false

	if abs(global_position.x - start_position.x) >= max_distance:
		direction *= -1

	if $Sprite2D:
		$Sprite2D.rotation += direction * speed * delta / 50.0
