extends KinematicBody2D

export var run_speed = 10
export var max_run_speed = 250
export var jump_speed = -300
export var gravity = 1000
export var hp_max = 100
export var hp = 100
export var damage = 10
export var strong_damage = 20
export var attack_cooldown = 500 #ms
export var dash_cooldown = 1000 #ms

#looking 1 = right 0 = left
var blocking = 0 
var fric = 5
var looking = 0
var attacking = 0
var dashing = 0
var velocity = Vector2()
var next_dash_time = 0
var next_attack_time = 0

func friction():
	if( velocity.x > 0):
		velocity.x -= fric
	if( velocity.x < 0):
		velocity.x += fric
	if(velocity.x > max_run_speed):
		velocity.x -= fric * 1.5
	if(velocity.x < -max_run_speed):
		velocity.x += fric * 1.5

func knockback(enemy_pos):
	if(enemy_pos.x>get_global_position().x):
		velocity.x -= max_run_speed * 2
	if(enemy_pos.x<get_global_position().x):
		velocity.x += max_run_speed * 2
		
func hit(damage_taken,enemy_pos):
	if(!blocking):
		hp -= damage_taken
		if(hp<0):
			hp = 0
	knockback(enemy_pos)
	
func turn():
	var current_cast = $ataque_fraco.get_cast_to()
	current_cast.x = -current_cast.x
	$ataque_fraco.set_cast_to(current_cast)
	
	current_cast = $ataque_forte.get_cast_to()
	current_cast.x = -current_cast.x
	$ataque_forte.set_cast_to(current_cast)
		
	get_node( "AnimatedSprite" ).set_flip_h( !looking )
	

func get_input():

	
	#Verifica o chão pra pular
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = jump_speed
		
	if Input.is_action_pressed('ui_right'):
		velocity.x += run_speed
		if(!looking):
			looking = 1
			turn()
		
	if Input.is_action_pressed('ui_left'):
		velocity.x -= run_speed
		if(looking):
			looking = 0
			turn()
			
	if Input.is_action_just_pressed("P2 dash"):
		if(!is_on_floor() && dashing == 0 ):
			var now = OS.get_ticks_msec()
			if now >= next_dash_time:
				dashing = 1
				velocity.x = velocity.x*2
				next_dash_time = now + dash_cooldown
		elif(is_on_floor()):
			var now = OS.get_ticks_msec()
			if now >= next_dash_time:
				if(looking == 1):
					velocity.x = velocity.x + 300
				if(looking == 0):
					velocity.x = velocity.x - 300
				next_dash_time = now + dash_cooldown
	
	if Input.is_action_pressed('P2 block'):
		blocking = 1
		
	if Input.is_action_pressed('P2 attack'):
		attacking = 1
		var now = OS.get_ticks_msec()
		if now >= next_attack_time:
			var target = $ataque_fraco.get_collider()
			$AnimatedSprite.set_frame(0)
			$AnimatedSprite.play("weak attack")
			if target != null:
#				if target.name.find("Player") >= 0:
					target.hit(damage,get_global_position())
			next_attack_time = now + attack_cooldown
			
	if Input.is_action_pressed('P2 strong attack'):
		attacking = 1
		var now = OS.get_ticks_msec()
		if now >= next_attack_time:
			var target = $ataque_forte.get_collider()
			if target != null:
					target.hit(strong_damage,get_global_position())
			next_attack_time = now + attack_cooldown
		
func _physics_process(delta):
	
	blocking = 0
	get_node("HP").text = "HP: {hp}".format({"hp":hp})
	get_node("Barra Vida").value = hp
	if(is_on_floor()):
		dashing = 0
	
	friction()
		
	velocity.y += gravity * delta
	
#	Codigo da animação vvvvvvv

#	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
#		$AnimatedSprite.play("run")
#	else:
#		$AnimatedSprite.stop()

	get_input()
	
#	Calculo do vetor movimento
	velocity = move_and_slide(velocity, Vector2(0, -1))

