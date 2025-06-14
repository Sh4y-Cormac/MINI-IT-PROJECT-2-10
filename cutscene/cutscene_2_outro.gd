extends Control

@onready var video_player = $VideoStreamPlayer

func _ready():
	video_player.play()


func _on_video_stream_player_finished() -> void:
	get_tree().change_scene_to_file("res://scenes-environment/game.tscn")
