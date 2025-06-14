extends Control

@export var description : NinePatchRect
var selected_item : Item


func _process(delta: float) -> void:
	update_gold_label()


func set_description(item : Item):
	selected_item = item
	description.find_child("Item Name").text = item.title
	description.find_child("Icon").texture = item.icon
	description.find_child("Description").text = item.description  
	description.find_child("Cost").text = "$" + str(item.price)
	

	
func update_gold_label():
	$"NinePatchRect/Coins Display/Label".text = "Gold: " + str(Global.playerGold)

func _on_buy_pressed() -> void:
	if selected_item and Global.playerGold >= selected_item.price:
		Global.playerGold -= selected_item.price
		update_gold_label()
		var item_copy = selected_item.duplicate()
		item_copy.origin_path = selected_item.resource_path
		InventoryManager.add_item(item_copy)
		
	else:
		print("Not enough gold!")


func _on_button_mouse_entered() -> void:
	$"../../audio/Hovering Sound Effect".play()


func _on_button_pressed() -> void:
	$"../../audio/Enter Sound Effect".play()
	await $"../../audio/Enter Sound Effect".finished
	$"../../Animations/ShopAnimation".play("Shop_Hide")
