extends Node

var player = 1

func _ready():
	Engine.target_fps = 60
	$MarginContainer/VBoxContainer/HBoxContainer/Button.grab_focus()
	
func player2():
	$MarginContainer/VBoxContainer/Player.text = "Player 2"
	if($MarginContainer/VBoxContainer/HBoxContainer/Button.disabled == false):
		$MarginContainer/VBoxContainer/HBoxContainer/Button.grab_focus()
	else:
		$MarginContainer/VBoxContainer/HBoxContainer/Button2.grab_focus()
	player = 2

func _on_Button_focus_entered():
	$MarginContainer/VBoxContainer/HBoxContainer/Button/Sprite.visible = true

func _on_Button_focus_exited():
	Sound.play_change()
	$MarginContainer/VBoxContainer/HBoxContainer/Button/Sprite.visible = false

func _on_Button2_focus_entered():
	$MarginContainer/VBoxContainer/HBoxContainer/Button2/Sprite.visible = true

func _on_Button2_focus_exited():
	Sound.play_change()
	$MarginContainer/VBoxContainer/HBoxContainer/Button2/Sprite.visible = false

func _on_Button3_focus_entered():
	$MarginContainer/VBoxContainer/HBoxContainer/Button3/Sprite.visible = true

func _on_Button3_focus_exited():
	Sound.play_change()
	$MarginContainer/VBoxContainer/HBoxContainer/Button3/Sprite.visible = false

func _on_Button4_focus_entered():
	$MarginContainer/VBoxContainer/HBoxContainer/Button4/Sprite.visible = true

func _on_Button4_focus_exited():
	Sound.play_change()
	$MarginContainer/VBoxContainer/HBoxContainer/Button4/Sprite.visible = false

func selectChar(charValue):
	var player_vars = get_node("/root/PlayerVariables")
	if(player == 1):
		player_vars.playerOneChar = charValue
	if(player == 2):
		player_vars.playerTwoChar = charValue
		get_tree().change_scene("res://Game.tscn")
	player2()

func _on_Button_pressed():
	Sound.play_button()
	selectChar(1)
	$"MarginContainer/VBoxContainer/HBoxContainer/Button".disabled = true


func _on_Button2_pressed():
	Sound.play_button()
	selectChar(2)
	$"MarginContainer/VBoxContainer/HBoxContainer/Button2".disabled = true


func _on_Button3_pressed():
	Sound.play_button()
	selectChar(3)
	$"MarginContainer/VBoxContainer/HBoxContainer/Button3".disabled = true


func _on_Button4_pressed():
	Sound.play_button()
	selectChar(4)
	$"MarginContainer/VBoxContainer/HBoxContainer/Button4".disabled = true
