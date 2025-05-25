extends Node2D

var is_triggered = false

func _ready():
	$Area2D.connect("body_entered", Callable(self, "_on_area_2d_body_entered"))

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player" and !is_triggered:
		is_triggered = true
		start_collapse()

func start_collapse():
	print("Collapse started")
	await get_tree().create_timer(0.3).timeout
	$StaticBody2D/CollisionShape2D_A.disabled = true  # Use your new name here
	var tween = create_tween()
	tween.tween_property(self, "position:y", position.y + 200, 0.5)
	tween.tween_callback(Callable(self, "queue_free"))
