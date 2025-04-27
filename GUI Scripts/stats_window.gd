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

@onready var label_hp: Label = $NinePatchRect/HP/Label_HP
@onready var label_atk: Label = $NinePatchRect/Atk/Label_ATK
@onready var label_def: Label = $NinePatchRect/Def/Label_DEF
@onready var label_lvl: Label = $NinePatchRect/LVL/Label_LVL


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
	print("Level Up! %d" % level)
	
func show_stat_gains():
	var stat_message = "Level Up!\n"
	stat_message += "HP: %d -> %d\n" % [last_hp, hp]
	stat_message += "ATK: %d -> %d\n" % [last_atk, atk]
	stat_message += "DEF: %d -> %d\n" % [last_def, def]
	
func _input(event):
	if event.is_action_pressed("toggle_stat"):
		visible = not visible
		
	if event.is_action_pressed("test_gain_exp"):
		gain_exp(100)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
