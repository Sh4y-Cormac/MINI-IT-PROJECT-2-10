extends Node

#Aiman here the things i put is still in WIP, im not sure if this it the thing that u were talking about but im just putting this to revamp my exp thing

##Game Values
var gameStarted: bool


## Player Values 
var playerBody: CharacterBody2D
var player_weapon_equip: bool
var playerDamageZone: Area2D
var playerDamageAmount: int
var playerHitbox: Area2D
var playerGold: int #amount of gold player has
var playerAlive: bool
var playerSkin: int #what skin the player has. Will determine the animations and stuff
var level: int ## determine what the next level that the player will go through.
var levels: Array = [
	"res://GUI Scenes/ShopIsland.tscn",
	"res://scenes-environment/actual levels/enviroment_level_1.tscn",
	"res://GUI Scenes/ShopIsland.tscn",
	"res://scenes-environment/actual levels/environment_desert.tscn",
	"res://GUI Scenes/ShopIsland.tscn",
	"res://scenes-environment/actual levels/environment_winter.tscn",
	"res://GUI Scenes/ShopIsland.tscn",
	"res://scenes-environment/actual levels/environment_space.tscn",
]
# WAN ADDED THIS
var player_exp: int = 0
var player_level: int = 1
var exp_max: int = 100

signal stats_updated(stats: Dictionary)
signal level_up

## Entity Values
var robotDamageZone: Area2D
var robotDamageAmount: int

var golemDamageZone: Area2D
var golemDamageAmount: int

var batDamageZone: Area2D
var batDamageAmount: int

# Player Health
var playerHealth := 100


#WAN ALSO ADDED THIS
func gain_exp(amount: int) -> bool:
	player_exp += amount
	var leveled_up := false
	while player_exp >= exp_max:
		player_exp -= exp_max
		player_level += 1
		exp_max = player_level * 100
		emit_signal("level_up")
		leveled_up = true
	return leveled_up
