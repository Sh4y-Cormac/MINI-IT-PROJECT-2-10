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
		icon.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		add_child(icon)

		if count > 1:
			var label = Label.new()
			label.text = "x" + str(count)
			label.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
			label.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
			label.add_theme_color_override("font_color", Color.WHITE)
			label.add_theme_font_size_override("font_size", 12)
			icon.add_child(label)

func clear_icons():
	for child in get_children():
		child.queue_free()
