extends Resource
class_name Item

var gold = 10000

@export var name: String
@export var title : String
@export var icon : CompressedTexture2D
@export_multiline var description : String
@export var price : String
@export_enum("Armor", "Weapon") var type: String




@export_group("Inventory Data")
@export var inventarSlot: String
@export var InventarPosition : int
