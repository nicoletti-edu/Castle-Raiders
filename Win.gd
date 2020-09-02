extends Node

func _ready():
	Sound.play_victory()
	Sound.stop_battle()
	$Button.grab_focus()
	if(PlayerVariables.playerOneHP > PlayerVariables.playerTwoHP):
		PlayerVariables.dead = 2
	elif(PlayerVariables.playerOneHP < PlayerVariables.playerTwoHP):
		PlayerVariables.dead = 1
	else:
		PlayerVariables.dead = 3
	
	var dead = PlayerVariables.dead
	if(dead == 1):
		dead = 2
	elif(dead == 2):
		dead = 1
	if(dead != 3):
		$MarginContainer/VBoxContainer/Player.add_text(str(dead))
	else:
		$MarginContainer/VBoxContainer/Player.text = "Empate"
		$MarginContainer/VBoxContainer/Win.queue_free()

func _on_Button_pressed():
	get_tree().change_scene("res://Main Menu.tscn")
	Sound.stop_victory()
