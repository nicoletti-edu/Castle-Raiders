extends RigidBody2D

func _process(delta):
	if(get_colliding_bodies()):
		print(get_colliding_bodies())
