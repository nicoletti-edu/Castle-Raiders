extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	
	rng.randomize()
	var nmr_plataforma = rng.randi_range(1,3)
	var local_plataforma = "res://Plataformas"+ str(nmr_plataforma) +".tscn"
	var plataforma_aleatoria = load(local_plataforma)

	var plataforma = plataforma_aleatoria.instance()
	self.add_child(plataforma)
