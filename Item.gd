extends Resource
class_name Item

var gold = 10000

@export var name: String
@export var title : String
@export var icon : CompressedTexture2D
@export_multiline var description : String
@export var price : int = 1
@export_enum("Armor", "Weapon", "Card") var type: String

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
