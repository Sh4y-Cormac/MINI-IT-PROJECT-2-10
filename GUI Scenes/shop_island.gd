extends Node2D

@onready var player_position = $SpawnPosition

# Called when the node enters the scene tree for the first time.
func _ready():
	Ui.MODE.ON
	$animation/DogAnimation.play("Dog_Sleep")


func _on_bag_icon_button_mouse_entered() -> void:
	$"audio/Hovering Sound Effect".play()
	$animation/BagAnimation.play("bag_animation")

func _on_bag_icon_button_mouse_exited() -> void:
	$animation/BagAnimation.play_backwards("bag_animation")


func _on_bag_icon_button_pressed() -> void:
	$"audio/Enter Sound Effect".play()
	await $"audio/Enter Sound Effect".finished
	$CanvasLayer/Inventory.visible = true
