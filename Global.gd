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

## Entity Values
var robotDamageZone: Area2D
var robotDamageAmount: int

var golemDamageZone: Area2D
var golemDamageAmount: int

## Player Health

var playerHealth: int = 100
var health: int = 5
var max_health: int = 5
var hearts_list: Array[TextureRect] = []

func setup_hearts(hearts_parent):
	hearts_list.clear()
	for child in hearts_parent.get_children():
		hearts_list.append(child)
	update_heart_display()
	
func take_damage():
	if health > 0:
		health -= 1
		update_heart_display()
		if health == 0:
			print("Player dead")
			
func update_heart_display():
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < health
