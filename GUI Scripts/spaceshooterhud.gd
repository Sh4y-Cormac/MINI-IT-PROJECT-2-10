extends Control

@onready var score = $GoldEarnedLabel:
	set(value):
		score.text = "Gold Earned: " + str(value)
		Global.playerGold += value
