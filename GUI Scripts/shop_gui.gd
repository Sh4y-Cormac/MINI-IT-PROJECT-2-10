extends Control

@export var description : NinePatchRect

func set_description(item):
	description.find_child("Item Name").text = item.title
	description.find_child("Information").text = item.description
	description.find_child("Icon").text = item.icon
