extends Node2D

@onready var instruction: RichTextLabel = $intruction
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var player = Global.playerBody
var is_chest_open: bool 
var hovering: bool 
var can_give_gold: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instruction.visible = false
	is_chest_open = false
	hovering = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_chest_open:
		animated_sprite_2d.play("closed")
		if hovering:
			animated_sprite_2d.play("highlight")
			if Input.is_action_just_pressed("interact"):
				open_chest()
				is_chest_open = true
				hovering = false
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
	can_give_gold = true
	if can_give_gold:
		Global.playerGold += 100
		can_give_gold = false
	elif !can_give_gold:
		print("gold has been given")

	##NOTE FOR AIMAN: This is where you will add code to put the item into inventory.
	pass 


	
	
