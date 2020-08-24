extends "res://Personage.gd"

# Public Identifiers

# Private Identifiers

# Methods Created

# Standard Methods
func _ready():
	id = 1
	var player_vars = get_node("/root/PlayerVariables")
	if(player_vars.playerOneChar == id):
		playerOne()
	else:
		playerTwo()
