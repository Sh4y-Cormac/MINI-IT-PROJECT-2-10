extends Control

@onready var video_player := $VideoStreamPlayer
var can_skip := true

func _ready() -> void:
	video_player.play()
	video_player.finished.connect(_on_video_finished)

func _process(delta: float) -> void:
	if can_skip and Input.is_action_just_pressed("ui_accept"):
		_end_cutscene()

func _on_video_finished() -> void:
	_end_cutscene()

func _end_cutscene() -> void:
	if not can_skip:
		return
	can_skip = false
	if video_player.is_playing():
		video_player.stop()
	get_tree().change_scene_to_file(Global.next_scene_after_cutscene)
