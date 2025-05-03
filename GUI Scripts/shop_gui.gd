extends Control

@export var description : NinePatchRect

var gold : int = 10000


func set_description(item : Item):
	description.find_child("Item Name").text = item.title
	description.find_child("Icon").texture = item.icon
	description.find_child("Description").text = item.description  
	description.find_child("Cost").text = item.price
	

	
func update_gold_label():
	$"Coins Display/Label".text = "Gold: " + str(gold)

func _on_buy_pressed() -> void:
		var price = 100  
		if gold >= price:
			gold -= price
			print("Bought item! New gold: ", gold)
			update_gold_label()
		else:
			print("Not enough gold!")
