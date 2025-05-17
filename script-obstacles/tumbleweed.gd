extends CharacterBody2D

@export var speed: float = 100.0
@export var max_distance: float = 150.0
@onready var tumbleweedtimer = $"../tumbleweedkill/Timer"

var direction := 1
var start_position := Vector2.ZERO

func _ready():
	start_position = global_position 

func _physics_process(delta):
	velocity.x = speed * direction
	move_and_slide()

	if abs(global_position.x - start_position.x) >= max_distance:
		direction *= -1

	if $Sprite2D:
		$Sprite2D.rotation += direction * speed * delta / 50.0
		

func _on_tumbleweedkill_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var col = body.get_node_or_null("CollisionShape2D")
		if col:
			col.queue_free()
		print("Player hit the killzone")
		tumbleweedtimer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
