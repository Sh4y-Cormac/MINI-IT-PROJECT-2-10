extends Control

@onready var object_container: HBoxContainer = %"Character Box"
@onready var scroll_container: ScrollContainer = %ScrollContainer

var targetscroll = 0

func _ready() -> void:
	_set_selection()

func _set_selection():
	await get_tree().create_timer(0.01).timeout

func _on_previous_button_pressed() -> void:
	$"../../Enter Sound Effect".play()
	var scrollvalue = targetscroll - _get_space_between()
	
	await _tween_scroll(scrollvalue)
	
	
	if scrollvalue <= 0  : scrollvalue = _get_space_between() * 3

func _on_next_button_pressed() -> void:
	$"../../Enter Sound Effect".play()
	var scrollvalue = targetscroll + _get_space_between()
	
	await _tween_scroll(scrollvalue)
	
	if scrollvalue >=  _get_space_between() * 3 : scrollvalue = 0

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
