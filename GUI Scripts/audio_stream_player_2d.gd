extends AudioStreamPlayer2D

var visible_char = 0

func _process(delta):
	if visible_char != $"../RichTextLabel".visible_characters:
		visible_char = $"../RichTextLabel".visible_characters
		$".".play()
