extends Control

# == Base Stats ==
var hp := 100
var atk := 10
var def := 5
var level := 1
var exp_max := level * 100
var max_hp := 100
var max_atk := 10

# == Last Level Snapshot ==
var last_hp := hp
var last_atk := atk
var last_def := def

# == Level-Up Animation ==
var fade_duration := 1.0
var fade_timer := 0.0
var fading_in := false
var fading_out := false
var fade_wait_timer := 0.0
var fade_hold_time := 2.0

# == Signals ==
signal leveled_up

# == UI References ==
@onready var label_hp: Label = $NinePatchRect/HP/Label_HP
@onready var label_atk: Label = $NinePatchRect/Atk/Label_ATK
@onready var label_def: Label = $NinePatchRect/Def/Label_DEF
@onready var label_lvl: Label = $NinePatchRect/LVL/Label_LVL
@onready var exp_bar: ProgressBar = $"../ExpBar"
@onready var level_up_announcement: Label = $"../LevelUpAnnouncement"

# == Lifecycle ==
func _ready() -> void:
	BuffManager.connect("buffs_updated", Callable(self, "update_stats_display"))
	update_stats()
	visible = false

# == STAT DISPLAY UPDATE ==
func update_stats_display(stats: Dictionary) -> void:
	hp = stats.get("hp", hp)
	atk = stats.get("atk", atk)
	def = stats.get("def", def)
	level = stats.get("level", level)
	exp_max = stats.get("exp_max", level * 100)
	max_hp = max(hp, max_hp)
	max_atk = max(atk, max_atk)
	update_stats()

func update_stats():
	exp_max = level * 100
	label_hp.text = str(hp)
	label_atk.text = str(atk)
	label_def.text = str(def)
	label_lvl.text = str(level)

	if exp_bar:
		exp_bar.max_value = exp_max
		exp_bar.value = Global.player_exp

# == EXP SYSTEM ==
func gain_exp(amount: int):
	Global.player_exp += amount
	var leveled_up = false
	
	while Global.player_exp >= exp_max:
		Global.player_exp -= exp_max
		level_up()
		leveled_up = true

	if not leveled_up:
		update_stats()
	emit_stats_update()

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
	update_stats()
	emit_stats_update()
	emit_signal("leveled_up")

func emit_stats_update():
	var current_stats = {
		"hp": hp,
		"atk": atk,
		"def": def,
		"level": level,
		"exp": Global.player_exp,
		"exp_max": exp_max
	}
	Global.emit_signal("stats_updated", current_stats)

func show_stat_gains():
	var msg := "Level Up!\n"
	msg += "HP: %d -> %d\n" % [last_hp, hp]
	msg += "ATK: %d -> %d\n" % [last_atk, atk]
	msg += "DEF: %d -> %d\n" % [last_def, def]
	print(msg)

# == Input (Debug) ==
#func _input(event):
	#if event.is_action_pressed("test_gain_exp"):
		#gain_exp(50)

# == Level Up Announcement ==
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
		var alpha = max(1.0 - fade_timer / fade_duration, 0.0)
		level_up_announcement.modulate.a = alpha
		if alpha <= 0.0:
			fading_out = false
			level_up_announcement.visible = false
