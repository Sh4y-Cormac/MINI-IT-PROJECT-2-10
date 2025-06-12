extends Control

@onready var video_player = $VideoStreamPlayer

func _ready():
	video_player.play()
	await video_player.finished

	Functions.load_screen_to_scene(Global.next_scene_after_cutscene)
