extends ProgressBar

func _ready():
	self.max_value = Global.playerMaxHealth
	self.visible = true      
	self.value = Global.playerHealth
	
func _process(delta):
	self.max_value = Global.playerMaxHealth
	self.value = Global.playerHealth
