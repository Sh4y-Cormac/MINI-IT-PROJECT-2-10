extends HBoxContainer

func set_cards(cards: Array[Resource]):
	clear_icons()
	var counts := {}

	for card in cards:
		var id = card.resource_path
		if counts.has(id):
			counts[id]["count"] += 1
		else:
			counts[id] = {"card": card, "count": 1}

	for entry in counts.values():
		var card = entry["card"]
		var count = entry["count"]

		var icon = TextureRect.new()
		icon.texture = card.card_icon
		icon.custom_minimum_size = Vector2(32, 32)
		icon.tooltip_text = card.name
		add_child(icon)

		if count > 1:
			var label = Label.new()
			label.text = "x" + str(count)
			icon.add_child(label)
			
func clear_icons():
	for child in get_children():
		child.queue_free()
		
