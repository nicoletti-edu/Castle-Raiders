extends RigidBody2D

func _ready():
	Sound.play_meteor()
	set_contact_monitor(true)
	set_max_contacts_reported(1)

var colidingBodies = null

func _process(delta):
	colidingBodies = get_colliding_bodies()
	if(colidingBodies.size() > 0):
		$AnimatedSprite.play("explode")
		Sound.stop_meteor()
		Sound.play_explosion()
		self.mode = 1
		if(!(colidingBodies[0] is TileMap)):
			colidingBodies[0].queue_free()
		yield($AnimatedSprite , "animation_finished")
		self.queue_free()
		
