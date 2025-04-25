extends Control


@export var animation_player : AnimationPlayer

func show_animation(first : String):
	animation_player.play("show_" + first)

func hide_animation(first : String):
	animation_player.play("hide_" + first)

enum STATE { FEEDBACK }

func _on_settings_button_mouse_entered() -> void:
	$"../../Hovering Sound Effect".play()


func _on_settings_button_pressed() -> void:
	STATE.FEEDBACK
	$"../../Enter Sound Effect".play()
	show_animation("options")


func _on_option_exit_button_mouse_entered() -> void:
	$"../../Hovering Sound Effect".play()

func _on_option_exit_button_pressed() -> void:
	$"../../Enter Sound Effect".play()
	hide_animation("options")


func _on_quit_button_mouse_entered() -> void:
	$"../../Hovering Sound Effect".play()


func _on_quit_button_pressed() -> void:
	$"../../Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	get_tree().quit()
