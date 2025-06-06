extends Control

@onready var object_container: HBoxContainer = %"Character Box"
@onready var scroll_container: ScrollContainer = %ScrollContainer


const characters = [
	preload("res://Assets/Sprites/Default.png"),
	preload("res://Assets/Sprites/Character 2.png"),
	preload("res://Assets/Sprites/Character 3.png"),
	preload("res://Assets/Sprites/Character 4.png"),
	preload("res://Assets/Sprites/Character 5.png")
]

var index_selection = 0
var targetscroll = 0
var char_potrait

func _ready() -> void:
	char_potrait = $"../../Responsive Background/Menu Background/Default Character"
	update_portrait(index_selection)
	_set_selection()
	
func update_portrait(index):
	char_potrait.texture = characters[index]
	
	## ADDED CODE HERE
	var character_skin = index
	Global.playerSkin = index

func _set_selection():
	await get_tree().create_timer(0.01).timeout
	_select_deselect_highlight()

func _on_previous_button_pressed() -> void:
	$"../../Enter Sound Effect".play()
	var scrollvalue = targetscroll - _get_space_between()
	if scrollvalue < 0 : scrollvalue = _get_space_between() * 4
	
	await _tween_scroll(scrollvalue)
	
	_select_deselect_highlight()
	
	if(index_selection > 0 ):
		index_selection -= 1
	elif(index_selection == 0):
		index_selection = characters.size() - 1



func _on_next_button_pressed() -> void:
	$"../../Enter Sound Effect".play()
	var scrollvalue = targetscroll + _get_space_between()
	
	if scrollvalue >=  _get_space_between() * 5 : scrollvalue = 0
	
	await _tween_scroll(scrollvalue)

	_select_deselect_highlight()
	
	if(index_selection < characters.size()-1 ):
		index_selection += 1
	elif(index_selection == characters.size() - 1):
		index_selection = 0


func _get_space_between():
	var distancesize = object_container.get_theme_constant("separation")
	var objectsize = object_container.get_children()[1].size.x
	
	return distancesize + objectsize

func _tween_scroll(scrollvalue):
	targetscroll = scrollvalue
	
	var tween = get_tree().create_tween()
	tween.tween_property(scroll_container, "scroll_horizontal", scrollvalue, 0.25)
	await tween.finished


func _on_previous_button_mouse_entered() -> void:
	$"../../Hovering Sound Effect".play()

func _on_next_button_mouse_entered() -> void:
	$"../../Hovering Sound Effect".play()

func _select_deselect_highlight():
	var selectNode = get_selected_value()
	
	for object in object_container.get_children():
		if object is not TextureRect: continue
		
		if object == selectNode: object.modulate= Color(1,1,1)
		else: object.modulate = Color(0,0,0)

func get_selected_value():
	var SelectedPosition = %"Selection Marker".global_position
	
	for object in object_container.get_children():
		if object.get_global_rect().has_point(SelectedPosition):
			return object
		


func _on_customize_save_button_pressed() -> void:
	update_portrait(index_selection) 
