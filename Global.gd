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

var crabDamageZone: Area2D
var crabDamageAmount: int


var playerHealth : int 

# Player Attributes : to increase the values, just add int values to it in the code. Everything should work fine.
var playerSpeedScaling : int
var playerDamageScaling : int
var playerMaxHealth : int
var availableJumps: int

#cutscene intro
var next_scene_after_cutscene: String = ""


func apple():
	playerHealth = min(playerHealth + 100 , 100)

func apple_slice():
	playerHealth = min(playerHealth + 50 , 100)

func blue_popsicle():
	playerDamageScaling *= 1.5
	await get_tree().create_timer(10.0).timeout
	playerDamageScaling /= 1.5
	
func green_popsicle():
	playerDamageScaling *= 2
	await get_tree().create_timer(15.0).timeout
	playerDamageScaling /= 2

func icecream1():
	playerSpeedScaling *= 1.5
	await get_tree().create_timer(10.0).timeout
	playerSpeedScaling /= 1.5

func icecream2():
	playerSpeedScaling *= 2
	await get_tree().create_timer(15.0).timeout
	playerSpeedScaling /= 2

func coffee():
	availableJumps += 1
	await get_tree().create_timer(10.0).timeout  
	availableJumps -= 1
