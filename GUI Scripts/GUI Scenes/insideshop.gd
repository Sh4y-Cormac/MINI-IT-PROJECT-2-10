extends Node2D


func _ready():
	Ui.MODE.ON
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
