extends Node2D

@onready var instruction: RichTextLabel = $intruction
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var player = Global.playerBody
var level = Global.level
var levels = Global.levels
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
	print("body entered")
	if body is Player:
		hovering = true
		print("Next level is", levels[level])


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		hovering = false

func teleport():
	if level < 8:
		var teleport_location = levels[level]
		add_level()
		Functions.load_screen_to_scene(teleport_location)
	elif level <= 8:
		var teleport_location = levels[0]
		reset_level()
		Functions.load_screen_to_scene(teleport_location)
	
func handle_animation():
	if hovering:
		animated_sprite_2d.play("highlighted")
	elif !hovering:
		animated_sprite_2d.play("normal")

func add_level():
	Global.level += 1
	Global.difficulty += 0.05
	
func reset_level():
	Global.level = 0
