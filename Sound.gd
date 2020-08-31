extends Node

func play_menu():
	$"Menu Background".play()

func play_button():
	$Button.play()

func play_change():
	$"Menu Change".play()

func play_battle():
	$"Battle Background".play()

func stop_battle():
	$"Battle Background".stop()

func play_king_laugh():
	$"King Laugh".play()

func play_meteor():
	$"Meteor Falling".play()

func stop_meteor():
	$"Meteor Falling".stop()

func play_explosion():
	$"Meteor Explosion".play()

func play_victory():
	$Victory.play()
