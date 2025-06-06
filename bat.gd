extends CharacterBody2D

class_name BatEnemy

const speed = 40
var is_enemy_chase: bool = true

var health = 100
var health_max = 100
var health_min = 0

var dead: bool = false
var taking_damage: bool = false
var damage_to_deal = 15
var is_dealing_damage: bool = false

var dir: Vector2
const gravity = 900 
var knockback_force = -200
var is_roaming: bool = false

var player: CharacterBody2D
var player_in_area = false

var droppedGold = 100
