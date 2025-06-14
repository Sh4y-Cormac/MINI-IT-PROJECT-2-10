extends TextureRect

@onready var label: Label = $Label

func set_card(card: Resource, count: int):
	texture = card.card_icon
	tooltip_text = card.name
	label.text = "x%d" % count if count > 1 else ""
