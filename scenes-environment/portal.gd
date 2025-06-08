extends Node2D

@onready var instruction: RichTextLabel = $intruction
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var player = Global.playerBody
var hovering: bool 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instruction.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_animation()
	if hovering:
		instruction.visible = true
		if Input.is_action_just_pressed("interact"):
			teleport()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		hovering = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		hovering = false

func teleport():
	get_tree().change_scene_to_file("res://GUI Scenes/ShopIsland.tscn")
	
func handle_animation():
	if hovering:
		animated_sprite_2d.play("highlighted")
	elif !hovering:
		animated_sprite_2d.play("normal")
