extends Node

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Engine.target_fps = 60
	$Button.grab_focus()
	Sound.play_menu()


func _process(_delta):
	if(!Sound.get_node("Menu Background").is_playing()):
		Sound.play_menu()


func _on_Button_pressed():
	Sound.play_button()
	get_tree().change_scene("res://Main Menu.tscn")
