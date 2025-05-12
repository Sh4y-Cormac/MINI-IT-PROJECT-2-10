extends Node2D

var health = 100

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if animated_sprite.animation == "hurt" and animated_sprite.is_playing():
		return
	if health > 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("death")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Sword"):
		health -= 10
		animated_sprite.play("hurt")
	if area.is_in_group("Longsword"):
		health -= 20
		animated_sprite.play("hurt")

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "death":
		queue_free()
