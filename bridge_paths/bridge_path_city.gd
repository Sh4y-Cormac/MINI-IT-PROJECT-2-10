extends Node2D

func lower_bridge():
	if $AnimationPlayer.is_playing():
		return
	$AnimationPlayer.play("fall")
