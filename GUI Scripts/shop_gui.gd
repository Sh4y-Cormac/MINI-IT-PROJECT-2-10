extends Control

@export var description : NinePatchRect

func set_description(item : Item):
	description.find_child("Item Name").text = item.title
	description.find_child("Icon").texture = item.icon
	description.find_child("Description").text = item.description  
