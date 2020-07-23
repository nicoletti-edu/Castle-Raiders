extends KinematicBody2D

var hp = 100

func hit(damage):
	hp -= damage

func _ready():
	get_node("HP").text = "HP: {hp}".format({"hp":hp})

func _physics_process(_delta):
	get_node("HP").text = "HP: {hp}".format({"hp":hp})


