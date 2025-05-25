extends Window

@onready var background = $ParallaxBackground

var scroll_speed = 100

func _process(delta):
	background.scroll_offset.y += delta * scroll_speed
	if background.scroll_offset.y > 500:
		background.scroll_offset.y = 0
