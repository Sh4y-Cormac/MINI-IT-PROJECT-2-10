extends CanvasLayer


enum MODE {
	ON,
	OFF
}

var mode : MODE = MODE.OFF:
	set(value):
		mode = value
		
		if value == MODE.OFF:
			$".".hide()
			
		elif value == MODE.ON:
			$".".show()
			
func _ready():
	pass


func _on_bag_icon_button_mouse_entered() -> void:
	$"audio/Hovering Sound Effect".play()
	$AnimationPlayer.play("bag_animation")


func _on_bag_icon_button_mouse_exited() -> void:
	$"audio/Hovering Sound Effect"
	$AnimationPlayer.play_backwards("bag_animation")


func _on_bag_icon_button_pressed() -> void:
	$"audio/Enter Sound Effect".play()
	await $"audio/Enter Sound Effect".finished
	$Inventory.visible = true
