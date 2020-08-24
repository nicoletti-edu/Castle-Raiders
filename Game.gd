extends Node2D

func _ready():
	var player_vars = get_node("/root/PlayerVariables")
	var cavaleiro = preload("res://Cavaleiro.tscn")
	var lanceiro = preload("res://Lanceiro.tscn")
	#var ladina = preload("res://")
	
	var characterOne = player_vars.playerOneChar
	var characterTwo = player_vars.playerTwoChar
	
	match characterOne:
		1:
			var cav = cavaleiro.instance()
			cav.position = $PlayerOneSpawn.position
			self.add_child(cav)
			
		2:
			var lanc = lanceiro.instance()
			lanc.position = $PlayerOneSpawn.position
			self.add_child(lanc)
		3:
			print("Barbaro")
		4:
			print("Ladina")
			
	match characterTwo:
		1:
			var cav = cavaleiro.instance()
			cav.position = $PlayerTwoSpawn.position
			self.add_child(cav)
		2:
			var lanc = lanceiro.instance()
			lanc.position = $PlayerTwoSpawn.position
			self.add_child(lanc)
		3:
			print("Barbaro")
		4:
			print("Ladina")

