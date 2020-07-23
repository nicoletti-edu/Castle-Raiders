extends Node2D

var rng = RandomNumberGenerator.new()
var rng_meteoro = RandomNumberGenerator.new()

onready var meteoros = preload("res://Meteoro.tscn")

func _ready():
	
	rng.randomize()
	var nmr_plataforma = rng.randi_range(1,2)
	var local_plataforma = "res://Plataformas"+ str(nmr_plataforma) +".tscn"
	var plataforma_aleatoria = load(local_plataforma)

	var plataforma = plataforma_aleatoria.instance()
	self.add_child(plataforma)
	
func _process(delta):
	var meteoro_cai = rng_meteoro.randi_range(1,500)
	if(meteoro_cai == 1):
		var meteoro = meteoros.instance()
		self.add_child(meteoro)
		
