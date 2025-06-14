extends Resource
class_name Item


@export var origin_path: String = ""
@export var global_function_name: String = ""

@export var name: String
@export var title : String
@export var icon : CompressedTexture2D
@export_multiline var description : String
@export var price : int
@export_enum("Armor", "Weapon", "Card") var type: String
@export var card_icon: Texture

@export_range(0.0, 1.0) var drop_chance: float = 1.0

@export var is_regen_card: bool = false
@export var regen_amount: float = 0.0
@export var regen_interval: float = 1.0

@export_group("Inventory Data")
@export var inventarSlot: String
@export var InventarPosition : int

@export var is_lifesteal_card: bool = false
@export var lifesteal_percent: float = 0.0  # 0.1 = 10%

@export_group("Stat Card Info")
@export var stat_name: String = ""       # e.g. "atk", "hp"
@export_enum("flat", "percent", "passive") var effect_type: String = "flat"
@export var value: float = 0.0


func use():
	if global_function_name != "":
		if Global.has_method(global_function_name):
			print("the function name is: ", global_function_name)
			Global.call(global_function_name)
			print("Used:", title)
		else:
			print("No function found:", global_function_name)
	else:
		print(title, " has no effect")
