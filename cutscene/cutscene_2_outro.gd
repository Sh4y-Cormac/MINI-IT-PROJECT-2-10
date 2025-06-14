extends Control

@onready var video_player = $VideoStreamPlayer

func _ready():
	video_player.play()


func _on_video_stream_player_finished() -> void:
	Functions.load_screen_to_scene("res://GUI Scripts/gameover.gd")
