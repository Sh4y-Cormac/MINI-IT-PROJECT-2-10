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


func _on_arcade_machine_mouse_entered() -> void:
	$"audio/Hovering Sound Effect".play()


func _on_arcade_machine_pressed() -> void:
	$"audio/Enter Sound Effect".play()
	await $"audio/Enter Sound Effect".finished
	start_minigame()


func start_minigame():
	get_tree().paused = true
	PhysicsServer2D.set_active(true)
	
	var spaceshooter = preload("res://GUI Scenes/SpaceShooterWindow.tscn").instantiate()
	
	get_tree().current_scene.add_child(spaceshooter)


func _on_shop_area_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
