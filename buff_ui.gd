extends HBoxContainer

@export var icon_scene: PackedScene  

func set_cards(cards: Array[Resource]):
	# Count duplicates
	var card_counts := {}
	for card in cards:
		var id = card.resource_path
		if card_counts.has(id):
			card_counts[id]["count"] += 1
		else:
			card_counts[id] = {"card": card, "count": 1}

	# Clear old icons
	for child in get_children():
		child.queue_free()

	# Create new icons
	for entry in card_counts.values():
		var card = entry["card"]
		var count = entry["count"]
		var icon = icon_scene.instantiate()
		icon.set_card(card, count)
		add_child(icon)
