extends RigidBody2D

func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(1)

var colidingBodies = null

func _process(delta):
	colidingBodies = get_colliding_bodies()
	if(colidingBodies.size() > 0):
		colidingBodies[0].queue_free()
		$AnimatedSprite.play("explode")
		$Falling.stop()
		$Explosion.play()
		self.mode = 1
		yield($AnimatedSprite , "animation_finished")
		yield($Explosion , "finished")
		self.queue_free()
		
