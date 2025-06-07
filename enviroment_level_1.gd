extends Node2D

func _ready():
	var hearts_parent = $HealthBar/HBoxContainer
	Global.setup_hearts(hearts_parent)
