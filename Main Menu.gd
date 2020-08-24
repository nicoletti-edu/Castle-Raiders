extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"MarginContainer/VBoxContainer/VBoxContainer/Button".grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://Start Menu.tscn")

func _on_Button_focus_entered():
	$MarginContainer/VBoxContainer/VBoxContainer/Button/Sprite.visible = true
func _on_Button_focus_exited():
	$MarginContainer/VBoxContainer/VBoxContainer/Button/Sprite.visible = false

func _on_Button2_focus_entered():
	$MarginContainer/VBoxContainer/VBoxContainer/Button2/Sprite2.visible = true
func _on_Button2_focus_exited():
	$MarginContainer/VBoxContainer/VBoxContainer/Button2/Sprite2.visible = false
	
func _on_Button2_pressed():
	get_tree().quit()



