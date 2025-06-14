extends Node2D

signal buffs_updated(final_stats: Dictionary)

var active_cards: Array[Resource] = []
var base_stats := {"hp": 100, "atk": 10, "def": 5}

func set_base_stats(stats: Dictionary):
	base_stats = stats
	emit_buff_update()

func set_cards(cards: Array[Resource]):
	active_cards = cards
	emit_buff_update()

func emit_buff_update():
	var final_stats = apply_cards_to_stats(base_stats, active_cards)
	emit_signal("buffs_updated", final_stats)

func apply_cards_to_stats(base: Dictionary, cards: Array[Resource]) -> Dictionary:
	var result = base.duplicate()
	for card in cards:
		if card.effect_type == "flat" and result.has(card.stat_name):
			result[card.stat_name] += card.value
		elif card.effect_type == "percent" and result.has(card.stat_name):
			result[card.stat_name] += base[card.stat_name] * card.value
	return result
