extends Control

@export var Options : NinePatchRect
@export var animation_player : AnimationPlayer
var centre : Vector2
@onready var node = $"Responsive Background"


func _ready():
	Ui.hide()
	$AnimationPlayer.play("Fade In")
	centre = Vector2(get_viewport_rect().size.x/100, get_viewport_rect().size.y/100)

func _process(_delta):
	var tween = node.create_tween()
	var offset = centre - get_global_mouse_position() * 0.1
	tween.tween_property(node, "position",offset,1.0)



func show_animation(first : String):
	animation_player.play("show_" + first)
	
func hide_animation(first : String):
	animation_player.play("hide_" + first)

enum STATE { FEEDBACK }

func _on_settings_button_pressed() -> void:
	STATE.FEEDBACK
	$"Enter Sound Effect".play()
	show_animation("options")
	$"Main Buttons/Start Button".disabled = true
	$"Main Buttons/Customise Button".disabled = true
	$"Main Buttons/Credits Button".disabled = true

func _on_start_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()
		
func _on_customise_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()

func _on_load_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()


func _on_start_button_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	Global.gameStarted = true
	Global.playerGold = 100
	Global.playerHealth = 100
	Global.playerMaxHealth = 100
	Global.level = 0
	Global.difficulty = 1
	Global.playerMaxHealth = 100
	Global.playerSpeedScaling = 1
	Global.playerDamageScaling = 1
	Global.availableJumps = 2

	get_tree().change_scene_to_file("res://cutscene/news_intro.tscn")

func _on_option_exit_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()

func _on_quit_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()

func _on_quit_button_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	get_tree().quit()
	
func _on_option_exit_button_pressed() -> void:
	$"Enter Sound Effect".play()
	hide_animation("options")
	$"Main Buttons/Start Button".disabled = false
	$"Main Buttons/Customise Button".disabled = false
	$"Main Buttons/Credits Button".disabled = false

func _on_settings_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()
	
	
func _on_customise_button_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	show_animation("customize")
	$"Main Buttons/Start Button".disabled = true
	$"Main Buttons/Customise Button".disabled = true
	$"Main Buttons/Credits Button".disabled = true
	$"Settings Button".disabled = true


func _on_customize_save_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()

func _on_customize_save_button_pressed() -> void:
	$"Enter Sound Effect".play()
	hide_animation("customize")
	$"Main Buttons/Start Button".disabled = false
	$"Main Buttons/Customise Button".disabled = false
	$"Main Buttons/Credits Button".disabled = false
	$"Settings Button".disabled = false


func _on_customize_exit_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()

func _on_customize_exit_button_pressed() -> void:
	$"Enter Sound Effect".play()
	hide_animation("customize")
	$"Main Buttons/Start Button".disabled = false
	$"Main Buttons/Customise Button".disabled = false
	$"Main Buttons/Credits Button".disabled = false
	$"Settings Button".disabled = false


func _on_credits_button_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	Functions.load_screen_to_scene("res://GUI Scenes/credit_scene.tscn")

func _on_credits_button_mouse_entered() -> void:
	$"Hovering Sound Effect"
