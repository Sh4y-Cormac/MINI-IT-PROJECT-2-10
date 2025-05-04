extends Control

var hp = 100
var atk = 15
var def = 10
var level = 1
var exp = 0 
var exp_max = level * 100

var last_hp = hp
var last_atk = atk
var last_def = def 

var fade_duration = 1.0
var fade_timer = 0.0
var fading_in = false
var fading_out = false
var fade_wait_timer = 0.0
var fade_hold_time = 2.0



@onready var label_hp: Label = $NinePatchRect/HP/Label_HP
@onready var label_atk: Label = $NinePatchRect/Atk/Label_ATK
@onready var label_def: Label = $NinePatchRect/Def/Label_DEF
@onready var label_lvl: Label = $NinePatchRect/LVL/Label_LVL
@onready var exp_bar: ProgressBar = $"../EXPBar"
@onready var level_up_announcement: Label = $"../LevelUpAnnouncement"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_stats()
	visible = false


func update_stats():
	exp_max = level * 100
	label_hp.text = " %d" % hp
	label_atk.text = " %d" % atk
	label_def.text = " %d" % def
	label_lvl.text = " %d" % level

	if exp_bar:
		exp_bar.max_value = exp_max
		exp_bar.value = exp
			
func gain_exp(amount:int):
	exp += amount
	while exp >= exp_max:
		exp -= exp_max
		level_up()
	update_stats()
	
func level_up():
	level += 1
	
	
	last_hp = hp
	last_atk = atk
	last_def = def 
	
	hp += 20
	atk += 10
	def += 5
	
	show_stat_gains()
	show_level_up_message("Level Up! %d" % level)
	print("Level Up! %d" % level)
	
func show_stat_gains():
	var stat_message = "Level Up!\n"
	stat_message += "HP: %d -> %d\n" % [last_hp, hp]
	stat_message += "ATK: %d -> %d\n" % [last_atk, atk]
	stat_message += "DEF: %d -> %d\n" % [last_def, def]
	print(stat_message)
	
func _input(event):
	if event.is_action_pressed("toggle_stat"):
		visible = not visible
		
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
