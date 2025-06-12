extends Control

func _ready():
	await get_tree().create_timer(4.0).timeout  

	var next_scene = preload("res://cutscene/cutscene_1_news.tscn").instantiate()


	next_scene.anchor_left = 0
	next_scene.anchor_right = 1
	next_scene.anchor_top = 0
	next_scene.anchor_bottom = 1
	next_scene.offset_left = 0
	next_scene.offset_top = 0
	next_scene.offset_right = 0
	next_scene.offset_bottom = 0

	get_tree().root.add_child(next_scene)
	await get_tree().process_frame
	self.queue_free()
