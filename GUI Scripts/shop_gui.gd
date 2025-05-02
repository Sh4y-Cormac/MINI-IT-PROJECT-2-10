extends Control

@export var description : NinePatchRect
@export var gold : int


func set_description(item : Item):
	description.find_child("Item Name").text = item.title
	description.find_child("Icon").texture = item.icon
	description.find_child("Description").text = item.description  
	description.find_child("Cost").text = item.price
	
	


func _on_buy_pressed() -> void:
	pass
