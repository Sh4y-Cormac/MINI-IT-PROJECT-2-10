extends Control

@export var shop_slot_node : PackedScene = preload("res://GUI Scenes/slot_shop.tscn")
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


func buy(item : Item):
	if item == null:
		return false
	


func free_previous_slot():
	for slot in shop_container.get_children():
		slot.free()

func load_shop_inventory():
	for item in shop_items:
		var shop_slot = shop_slot_node.instantiate()
		shop_container.add_child(shop_slot)
		shop_slot.item = item

func set_shop_inventory(list: Array[Item]):
	free_previous_slot()
	shop_items = list
	load_shop_inventory()
