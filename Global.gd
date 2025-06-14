extends Node

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
var difficulty: float

## Entity Values
var robotDamageZone: Area2D
var robotDamageAmount: int

var golemDamageZone: Area2D
var golemDamageAmount: int

var batDamageZone: Area2D
var batDamageAmount: int

var skullDamageZone: Area2D
var skullDamageAmount: int

var playerHealth : int 

# Player Attributes : to increase the values, just add int values to it in the code. Everything should work fine.
var playerSpeedScaling : int
var playerDamageScaling : int
var playerMaxHealth : int
var availableJumps: int

#cutscene intro
var next_scene_after_cutscene: String = ""
