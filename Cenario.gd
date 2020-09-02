extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	
	rng.randomize()
	var nmr_plataforma = rng.randi_range(1,7)
	var local_plataforma = "res://Plataformas"+ str(nmr_plataforma) +".tscn"
	var plataforma_aleatoria = load(local_plataforma)

	var plataforma = plataforma_aleatoria.instance()
	self.add_child(plataforma)


func _on_Death_body_entered(body):
	if(body.is_in_group("Player")):
		body.die()


func _on_Timer_timeout():
	get_parent().get_tree().change_scene("res://Win.tscn")
