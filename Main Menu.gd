extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"MarginContainer/VBoxContainer/VBoxContainer/Button".grab_focus()

func _process(_delta):
	if(!Sound.get_node("Menu Background").is_playing()):
		Sound.play_menu()
	if Input.is_action_just_pressed('ui_cancel'):
		get_tree().quit()

func _on_Button_pressed():
	get_tree().change_scene("res://Start Menu.tscn")
	Sound.play_button()

func _on_Button_focus_entered():
	$MarginContainer/VBoxContainer/VBoxContainer/Button/Sprite.visible = true
func _on_Button_focus_exited():
	$MarginContainer/VBoxContainer/VBoxContainer/Button/Sprite.visible = false
	Sound.play_change()

func _on_Button2_focus_entered():
	$MarginContainer/VBoxContainer/VBoxContainer/Button2/Sprite2.visible = true
func _on_Button2_focus_exited():
	$MarginContainer/VBoxContainer/VBoxContainer/Button2/Sprite2.visible = false
	Sound.play_change()
	
func _on_Button2_pressed():
	Sound.play_button()
	get_tree().quit()



