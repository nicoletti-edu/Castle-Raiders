extends Node2D

func _ready():
	var player_vars = get_node("/root/PlayerVariables")
	var characterOne = player_vars.playerOneChar
	match characterOne:
		1:
			print("Cavaleiro")
		2:
			print("Lanceiro")
		3:
			print("Barbaro")
		4:
			print("Ladina")

	var characterTwo = player_vars.playerTwoChar
	match characterTwo:
		1:
			print("Cavaleiro")
		2:
			print("Lanceiro")
		3:
			print("Barbaro")
		4:
			print("Ladina")

