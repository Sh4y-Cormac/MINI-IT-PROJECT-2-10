extends Node2D


func _ready():
	$Animations/OrgAnimation.play("org_animation")

func _on_bag_icon_button_mouse_entered() -> void:
	$"audio/Hovering Sound Effect".play()
	$AnimationPlayer.play("bag_animation")

func _on_bag_icon_button_mouse_exited() -> void:
	$AnimationPlayer.play_backwards("bag_animation")


func _on_bag_icon_button_pressed() -> void:
	$"audio/Enter Sound Effect".play()
	await $"audio/Enter Sound Effect".finished
	$CanvasLayer/Inventory.visible = true
