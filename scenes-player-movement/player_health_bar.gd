extends ProgressBar

func _ready():
	self.max_value = 100
	self.visible = true      
	self.value = Global.playerHealth
	
func _process(delta):
	self.value = Global.playerHealth
