extends TextureRect

@onready var count_label: Label = $CountLabel


func set_card(card: Resource, count: int):
	texture = card.card_icon
	tooltip_text = card.name
	count_label.text = "x" + str(count) if count > 1 else ""
