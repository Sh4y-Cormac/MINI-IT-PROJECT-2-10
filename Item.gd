extends Resource
class_name Item

var gold = 10000

@export var name: String
@export var title : String
@export var icon : CompressedTexture2D
@export_multiline var description : String
@export var price : String
@export_enum("Armor", "Weapon", "Card") var type: String



@export_group("Inventory Data")
@export var inventarSlot: String
@export var InventarPosition : int

@export_group("Stat Card Info")
@export var stat_name: String = ""       # e.g. "atk", "hp"
@export_enum("flat", "percent", "passive") var effect_type: String = "flat"
@export var value: float = 0.0
