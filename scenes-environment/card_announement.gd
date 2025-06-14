extends Control

@onready var card_announcement: Label = $CardAnnouncement

var fade_duration := 1.0
var fade_timer := 0.0
var fade_hold := 2.0
var fading_in := false
var fading_out := false
var fade_wait_timer := 0.0

func show_card_announcement(text: String):
	card_announcement.text = text
	card_announcement.visible = true
	card_announcement.modulate.a = 0.0
	fading_in = true
	fade_timer = 0.0
	fade_wait_timer = 0.0
	fading_out = false

func _process(delta: float) -> void:
	if fading_in:
		fade_timer += delta
		var alpha = min(fade_timer / fade_duration, 1.0)
		card_announcement.modulate.a = alpha
		if alpha >= 1.0:
			fading_in = false
	elif not fading_out and card_announcement.visible:
		fade_wait_timer += delta
		if fade_wait_timer >= fade_hold:
			fading_out = true
			fade_timer = 0.0
	elif fading_out:
		fade_timer += delta
		var alpha = max(1.0 - fade_timer / fade_duration, 0.0)
		card_announcement.modulate.a = alpha
		if alpha <= 0.0:
			fading_out = false
			card_announcement.visible = false
