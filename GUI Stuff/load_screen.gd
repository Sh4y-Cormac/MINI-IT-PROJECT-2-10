extends CanvasLayer

@export_file("*.tscn") var next_scene_path: String

@export var scene_args : Array
@export var tips : Array[Dictionary] = [
	{"title": "Survival", "text": "Don't let your enemies kill you!"},
	{"title": "Survival", "text": "Swords will always be useful!"},
	{"title": "Survival", "text": "Potions might get you out of a sticky situation!"},
	{"title": "Movement", "text": "Try pressing that space-bar 2 times!"},
	{"title": "Movement", "text": "I wish we could go faster..."},
	{"title": "Defense", "text": "No armor is best armor"},
]



func _ready():
	var selected_tip := tips[randi() % tips.size()]
	%"Tips Label".text = "Tip: %s" % selected_tip.title
	%Tips.text = selected_tip.text
	$Control/AnimationPlayer.play("loading")
	ResourceLoader.load_threaded_request(next_scene_path)
	
func _process(delta):
	if ResourceLoader.load_threaded_get_status(next_scene_path) == ResourceLoader.THREAD_LOAD_LOADED:
		set_process(false)
		await get_tree().create_timer(1).timeout
		var new_scene: PackedScene = ResourceLoader.load_threaded_get(next_scene_path)
		get_tree().change_scene_to_packed(new_scene)
	
