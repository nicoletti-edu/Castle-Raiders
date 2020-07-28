extends KinematicBody2D

export var run_speed = 10
export var max_run_speed = 250
export var jump_speed = -300
export var gravity = 1000
export var hp_max = 100
export var hp = 100
export var damage = 10
export var strong_damage = 20

# FLAGS

#looking 1 = right 0 = left
var looking = 0

var blocking = 0 

var attack_timer = null
var can_attack = true
var attack_timer_delay = 0.5

var dash_timer = null
var dash_timer_delay = 2
var can_dash = true

var i_frame = 0

var fric = 5
var velocity = Vector2()

func _ready():
	attack_timer = Timer.new()
	attack_timer.set_one_shot(true)
	attack_timer.set_wait_time(attack_timer_delay)
	attack_timer.connect("timeout",self,"on_attack")
	
	dash_timer = Timer.new()
	dash_timer.set_one_shot(true)
	dash_timer.set_wait_time(attack_timer_delay)
	dash_timer.connect("timeout",self,"on_dash")
	
	add_child(attack_timer)
	add_child(dash_timer)
	
func on_attack():
	can_attack = true

func on_dash():
	can_dash = true	

#Slows the character down
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
			
	if Input.is_action_just_pressed("P2 down"):
		position.y += 1
			
	if Input.is_action_just_pressed("P2 dash") && can_dash:
		if(!is_on_floor()):
			#Counts between the time now and the next dash
				velocity.x = velocity.x*2
				can_dash = false
				dash_timer.start()
				
		elif(is_on_floor()):
				if(looking == 1):
					velocity.x = velocity.x + 300
				if(looking == 0):
					velocity.x = velocity.x - 300

				
	if Input.is_action_pressed('P2 block'):
		blocking = 1

	if Input.is_action_pressed('P2 attack') && can_attack:
		#Play Animation
		$AnimatedSprite.set_frame(0)
		$AnimatedSprite.play("weak attack")
		
		var target = $ataque_fraco.get_collider()
		if target != null:
				target.hit(damage,get_global_position())
				
		can_attack = false
		attack_timer.start()
			
	if Input.is_action_pressed('P2 strong attack') && can_attack:	
		var target = $ataque_forte.get_collider()
		if target != null:
				target.hit(strong_damage,get_global_position())
				
		can_attack = false
		attack_timer.start()
			
func _process(_delta):
	#Resets blocking
	blocking = 0
	
	#Updates HP bar
	get_node("HP").text = "HP: {hp}".format({"hp":hp})
	get_node("Barra Vida").value = hp
		
	#	Codigo da animação vvvvvvv

#	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
#		$AnimatedSprite.play("run")
#	else:
#		$AnimatedSprite.stop()


func _physics_process(delta):
	friction()
	velocity.y += gravity * delta

	get_input()
	
#	Calculo do vetor movimento
	velocity = move_and_slide(velocity, Vector2(0, -1))

