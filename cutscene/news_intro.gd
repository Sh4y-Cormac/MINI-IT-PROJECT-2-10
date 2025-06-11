extends Control
signal finished

func _ready():
	
	await get_tree().create_timer(4.0).timeout  

	var next_scene = preload("res://cutscene/cutscene_1_news.tscn").instantiate()
	get_tree().current_scene.get_parent().add_child(next_scene)
	get_tree().current_scene.queue_free()

	emit_signal("finished")
