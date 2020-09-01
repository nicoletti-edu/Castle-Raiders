extends Node

func _ready():
	Sound.play_victory()
	Sound.stop_battle()
	$Button.grab_focus()
	var dead = PlayerVariables.dead
	if(dead == 1):
		dead = 2
	else:
		dead = 1
	$MarginContainer/VBoxContainer/Player.add_text(str(dead))


func _on_Button_pressed():
	get_tree().change_scene("res://Main Menu.tscn")
	Sound.stop_victory()
