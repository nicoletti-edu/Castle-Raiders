extends Node2D

var rng_meteoro = RandomNumberGenerator.new()
var rng_posicao_meteoro = RandomNumberGenerator.new()

var meteor_cooldown = 10
var meteor_timer = null

onready var meteoros = preload("res://Meteoro.tscn")
var meteoro = null
var spawn = 0
var local_meteoro = null

func _ready():
	meteor_timer = Timer.new()
	meteor_timer.set_one_shot(false)
	meteor_timer.set_wait_time(meteor_cooldown)
	meteor_timer.connect("timeout",self,"on_meteor")
	
	add_child(meteor_timer)
	meteor_timer.start()
	
func on_meteor():
	spawn = 1
	
func _process(_delta):
	if(spawn == 1):
		meteoro = meteoros.instance()
		get_node("Spawn Meteoro {rng}".format({"rng":rng_posicao_meteoro.randi_range(1,11)})).add_child(meteoro)
		spawn = 0
