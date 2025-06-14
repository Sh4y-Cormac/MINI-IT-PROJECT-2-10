extends Control

var hp = 100
var atk = 10
var def = 5
var level = 1
@warning_ignore("shadowed_global_identifier")
var exp_max = level * 100
var max_hp = 100 
var max_atk = 10

var last_hp = hp
var last_atk = atk
var last_def = def 

var fade_duration = 1.0
var fade_timer = 0.0
var fading_in = false
var fading_out = false
var fade_wait_timer = 0.0
var fade_hold_time = 2.0

var regen_timer := 0.0
var regen_interval := 0.0
var regen_amount := 0.0
var has_regen := false

var lifesteal_percent := 0.0

signal leveled_up

@onready var label_hp: Label = $NinePatchRect/HP/Label_HP
@onready var label_atk: Label = $NinePatchRect/Atk/Label_ATK
@onready var label_def: Label = $NinePatchRect/Def/Label_DEF
@onready var label_lvl: Label = $NinePatchRect/LVL/Label_LVL
@onready var exp_bar: ProgressBar = $EXPbar/ExpBar
@onready var level_up_announcement: Label = $"../LevelUpAnnouncement"



	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.connect("stats_updated", Callable(self, "update_stats_display"))
	update_stats()
	visible = false

func _on_buffs_updated(final_stats: Dictionary):
	hp = int(final_stats["hp"])
	atk = int(final_stats["atk"])
	def = int(final_stats["def"])
	update_stats()
	
func apply_regen_card(card):
	has_regen = true
	regen_interval = card.regen_interval
	regen_amount = card.regen_amount
	regen_timer = 0.0  
	
func set_lifesteal(value: float):
	lifesteal_percent = value
	print("Lifesteal set to:", lifesteal_percent * 100, "%")#this might need to be in player script but we put here for now
	
func on_player_dealt_damage(amount: float):
	if lifesteal_percent > 0:
		var healed = amount * lifesteal_percent
		hp = min(hp + healed, max_hp)
		update_stats()
		print("Lifesteal: Recovered", healed, "HP")#this might need to be in player script but we put here for now
		
func heal(amount: float):
	if amount <= 0: return
	var actual = min(amount, max_hp - hp)
	hp += actual
	update_stats()
	print("Healed:", actual, "HP")

func update_stats_display(stats: Dictionary) -> void:
	hp = stats["hp"]
	atk = stats["atk"]
	def = stats["def"]
	
	max_hp = max(hp, max_hp)
	max_atk = max(atk, max_atk)
	
	update_stats()
	
func update_stats():
	exp_max = level * 100
	label_hp.text = str(int(hp))
	label_atk.text = str(int(atk))
	label_def.text = str(int(def))
	label_lvl.text = str(level)

	if exp_bar:
		exp_bar.max_value = exp_max
		exp_bar.value = Global.player_exp
		
	
func gain_exp(amount:int):
	Global.player_exp += amount
	
	var leveled_up = false 
	while Global.player_exp >= exp_max:
		Global.player_exp -= exp_max
		level_up()
		leveled_up = true 
		
	if not leveled_up:
		update_stats()
		
	Global.emit_signal("stats_updated",{
			"hp": hp,
			"atk": atk,
			"def": def,
			"level": level,
			"exp": Global.player_exp,
			"exp_max": exp_max} )

	
func level_up():
	level += 1
	
	
	last_hp = hp
	last_atk = atk
	last_def = def 
	
	hp += 20
	atk += 10
	def += 5
	max_hp += 20
	max_atk += 10
	
	show_stat_gains()
	show_level_up_message("Level Up! %d" % level)
	print("Level Up! %d" % level)
	
	update_stats()
	
	var current_stats_dict = {
		"hp": hp,
		"atk": atk,
		"def": def,
		"level": level,
		"exp": Global.player_exp,
		"exp_max": exp_max
	}
	Global.emit_signal("stats_updated", current_stats_dict)
	
	emit_signal("leveled_up")
	
func show_stat_gains():
	var stat_message = "Level Up!\n"
	stat_message += "HP: %d -> %d\n" % [last_hp, hp]
	stat_message += "ATK: %d -> %d\n" % [last_atk, atk]
	stat_message += "DEF: %d -> %d\n" % [last_def, def]
	print(stat_message)
	
func _input(event):
	#if event.is_action_pressed("toggle_stat"):
		#visible = not visible
		
	if event.is_action_pressed("test_gain_exp"):
		gain_exp(50)
		


func show_level_up_message(text: String):
	level_up_announcement.text = text
	level_up_announcement.modulate.a = 0.0
	level_up_announcement.visible = true
	fading_in = true
	fade_timer = 0.0
	fade_wait_timer = 0.0
	fading_out = false

func _process(delta: float) -> void:
	if fading_in:
		fade_timer += delta
		var alpha = min(fade_timer / fade_duration, 1.0)
		level_up_announcement.modulate.a = alpha
		if alpha >= 1.0:
			fading_in = false
			fade_wait_timer = 0.0
	elif not fading_in and not fading_out and level_up_announcement.visible:
		fade_wait_timer += delta
		if fade_wait_timer >= fade_hold_time:
			fading_out = true
			fade_timer = 0.0
	elif fading_out:
		fade_timer += delta
		var alpha = max(1.0 - (fade_timer / fade_duration), 0.0)
		level_up_announcement.modulate.a = alpha
		if alpha <= 0.0:
			fading_out = false
			level_up_announcement.visible = false

	if has_regen:
		regen_timer += delta
		if regen_timer >= regen_interval:
			var healed = regen_amount
			hp = min(hp + healed, max_hp)  
			update_stats()
			regen_timer = 0.0
