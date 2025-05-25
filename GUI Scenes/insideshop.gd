extends Node2D

@onready var minigame = $Node/Window

func _ready():
	minigame.hide()
	$Animations/OrgAnimation.play("org_animation")

func _on_bag_icon_button_mouse_entered() -> void:
	$"audio/Hovering Sound Effect".play()
	$Animations/BagAnimation.play("bag_animation")

func _on_bag_icon_button_mouse_exited() -> void:
	$Animations/BagAnimation.play_backwards("bag_animation")


func _on_bag_icon_button_pressed() -> void:
	$"audio/Enter Sound Effect".play()
	await $"audio/Enter Sound Effect".finished
	$CanvasLayer/Inventory.visible = true


func _on_arcade_machine_mouse_entered() -> void:
	$"audio/Hovering Sound Effect".play()


func _on_arcade_machine_pressed() -> void:
	$"audio/Enter Sound Effect".play()
	await $"audio/Enter Sound Effect".finished
	get_tree().paused = true
	minigame.show()


func _on_window_close_requested() -> void:
	get_tree().paused = false
	minigame.hide()
