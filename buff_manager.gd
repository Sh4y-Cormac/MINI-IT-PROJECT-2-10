extends Node2D

signal buffs_updated(final_stats: Dictionary)

var base_stats := {"hp": 100, "atk": 10, "def": 5}
var active_cards: Array[Resource] = []

func set_base_stats(stats: Dictionary):
	base_stats = stats.duplicate()
	apply_buffs()

func add_card(card: Resource):
	active_cards.append(card)
	apply_buffs()

func remove_card(card: Resource):
	active_cards.erase(card)
	apply_buffs()

func apply_buffs():
	var final_stats = base_stats.duplicate()

	for card in active_cards:
		if card.effect_type == "flat" and final_stats.has(card.stat_name):
			final_stats[card.stat_name] += card.value
	for card in active_cards:
		if card.effect_type == "percent" and final_stats.has(card.stat_name):
			final_stats[card.stat_name] += base_stats[card.stat_name] * card.value

	emit_signal("buffs_updated", final_stats)
