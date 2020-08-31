extends Node

func _ready():
	Sound.play_victory()
	Sound.stop_battle()
	var dead = PlayerVariables.dead
	if(dead == 1):
		dead = 2
	else:
		dead = 1
	$MarginContainer/VBoxContainer/Player.add_text(str(dead))
