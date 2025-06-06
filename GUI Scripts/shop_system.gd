extends Control

@export var shop_slot : PackedScene = preload("res://GUI Scenes/slot_shop.tscn")
@export var shop_items : Array[Item]
@export var shop_container : VBoxContainer

var gold : int = 0:
	set(value):
		gold = value
		
		$UI/Currency.text = "Gold : " + str(value)

enum MODE {
	ON,
	OFF
}

var mode : MODE = MODE.OFF:
	set(value):
		mode = value
		
		if value == MODE.OFF:
			$UI.hide()
			
		elif value == MODE.ON:
			$UI.show()
			
func _ready():
	$UI.hide()
	load_shop_inventory()

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_U:
			if mode == MODE.ON:
				mode = MODE.OFF
			elif mode == MODE.OFF:
				mode = MODE.ON

func buy(item : Item):
	if item == null:
		return false
	
	gold -= item.price
	return true

func free_previous_slot():
	for slot in shop_container.get_children():
		slot.free()

func load_shop_inventory():
	for item in shop_items:
		var shop_slot_node = shop_slot.instantiate()
		shop_container.add_child(shop_slot_node)
		shop_slot_node.item = item
		
		
