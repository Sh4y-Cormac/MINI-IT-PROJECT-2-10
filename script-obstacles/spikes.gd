extends Area2D

func _on_spike_body_entered(body):
	if body.name == "player":  
		if Global.playerHealth > 0:
			Global.playerHealth -= 1
			print("Player hit spike! Health now:", Global.playerHealth)

			if Global.playerHealth <= 0:
				Global.playerAlive = false
				print("Player died!")
