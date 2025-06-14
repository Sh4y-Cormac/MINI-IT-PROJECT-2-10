extends Node2D

## increases the max health of the player, along with healing them for a bit.
@onready var instruction: RichTextLabel = $intruction
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var player = Global.playerBody
var is_chest_open: bool 
var hovering: bool 
var can_give_health: bool


func _ready() -> void:
	instruction.visible = false
	is_chest_open = false
	hovering = false


func _process(delta: float) -> void:
	if !is_chest_open:
		animated_sprite_2d.play("closed")
		if hovering:
			animated_sprite_2d.play("highlight")
			if Input.is_action_just_pressed("interact"):
				open_chest()
				is_chest_open = true
				hovering = false
		elif !hovering:
			return
	elif is_chest_open:
		animated_sprite_2d.play("open")
		instruction.visible = false
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if !is_chest_open:
			hovering = true
			instruction.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		if !is_chest_open:
			instruction.visible = false

func open_chest():
	can_give_health = true
	if can_give_health:
		Global.playerMaxHealth += 20
		Global.playerHealth += 20
		can_give_health = false
	elif !can_give_health:
		pass
	is_chest_open = true
	animated_sprite_2d.play("open")
	instruction.visible = false
