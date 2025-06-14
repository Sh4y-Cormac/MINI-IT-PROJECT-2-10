extends ProgressBar

func _ready():
	Global.connect("stats_updated", Callable(self, "_on_stats_updated"))

func _on_stats_updated(data: Dictionary):
	update_bar(data["exp"], data["exp_max"])
	
func update_bar(current_exp: int, max_exp: int):
	value = current_exp
	max_value = max_exp
	
