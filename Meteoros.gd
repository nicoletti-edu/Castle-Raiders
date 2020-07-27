extends Node2D

var rng_meteoro = RandomNumberGenerator.new()
var rng_posicao_meteoro = RandomNumberGenerator.new()

onready var meteoros = preload("res://Meteoro.tscn")
var meteoro = null
var meteoro_cai = null
var local_meteoro = null
func _process(_delta):
	meteoro_cai = rng_meteoro.randi_range(1,500)
	if(meteoro_cai == 1):
		meteoro = meteoros.instance()
		get_node("Spawn Meteoro {rng}".format({"rng":rng_posicao_meteoro.randi_range(1,11)})).add_child(meteoro)
