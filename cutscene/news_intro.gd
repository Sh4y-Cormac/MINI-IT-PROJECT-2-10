extends Control
signal finished

func _ready():
	# main animasi/video/news intro
	await get_tree().create_timer(3.0).timeout  # adjust ikut panjang clip
	emit_signal("finished")
