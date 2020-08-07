extends KinematicBody2D

# Public Identifiers

# Protected Identifiers
	# Config buttons
var walk_left_button = 'none'
var walk_right_button = 'none'
var walk_down_button = 'none'
var weak_skill_button = 'none'
var strong_skill_button = 'none'
var jump_skill_button = 'none'
var dash_skill_button = 'none'

	# Stats APAGAR
var run_speed = 10
var max_run_speed = 250
var hp_max = 100

	# Stats
var move_speed = 10
var max_move_speed = 250
var current_hp = 100
var max_hp = 100
var damage = 10
var gravity = 1000

	# Movement
var velocity = Vector2()
var friction_value = 5
var looking = 0 # 1 = right | 0 = left

	# Skills
		# weak
var weak_damage = damage
var weak_activable = true
var weak_cooldown = 0.5
var weak_timer = null
		# strong
var strong_damage = damage * 2
var strong_activable = true
var strong_cooldown = 1.0
var strong_timer = null
		# jump
var jump_force = 800 # -300
var jump_activable = true
var jump_cooldown = 0.5
var jump_timer = null
		#dash
var dash_speed = 300 
var dash_activable = true
var dash_cooldown = 1.5
var dash_timer = null


# Methods Created
func get_input():	
	# Movement
	if Input.is_action_pressed(walk_left_button):
		movement_controller('left')
	if Input.is_action_pressed(walk_down_button):
		movement_controller('down')
	if Input.is_action_pressed(walk_right_button):
		movement_controller('right')		
	# Skill
	if Input.is_action_just_pressed(weak_skill_button):
		weak_controller()
	if Input.is_action_just_pressed(strong_skill_button):
		strong_controller()
	if Input.is_action_just_pressed(jump_skill_button):
		jump_controller()
	if Input.is_action_just_pressed(dash_skill_button):
		dash_controller()


func movement_controller(direction):
	if direction == 'down':
		position.y += 1
		return
	elif direction == 'left':
		velocity.x -= run_speed
		if looking == 0:
			looking = 1
			turn()
	elif direction == 'right':
		velocity.x += run_speed
		if looking == 1:
			looking = 0	
			turn()


func weak_controller():
	if !weak_activable:
		return
	print("Usou a habilidade")
	var target = $WeakSkill.get_collider()
	print(target)
	if target != null:
		target.hit(damage, get_global_position())				
	wait_weak()

	
func strong_controller():
	if !strong_activable:
		return
	var target = $StrongSkill.get_collider()
	if target != null:
		target.hit(damage, get_global_position())
	wait_strong()

	
func jump_controller():
	if !jump_activable:
		return
	if is_on_floor():
		 velocity.y = -jump_force
	wait_jump()

	
func dash_controller():
	if !dash_activable:
		return
	if(looking == 0):
		velocity.x = velocity.x + dash_speed
	if(looking == 1):
		velocity.x = velocity.x - dash_speed
	wait_dash()
	

func turn():
	$WeakSkill.set_cast_to(-$WeakSkill.get_cast_to())
	$StrongSkill.set_cast_to(-$StrongSkill.get_cast_to())
	$Sprite.set_flip_h(looking)	
	
	
func hit(damage_taken,enemy_pos):
	current_hp -= damage_taken
	if(current_hp<0):
		current_hp = 0		

	
func wait_weak():
	weak_activable = false
	weak_timer.start()

	
func wait_strong():
	strong_activable = false
	strong_timer.start()

	
func wait_jump():
	jump_activable = false
	jump_timer.start()

	
func wait_dash():
	dash_activable = false
	dash_timer.start()

		
func on_weak():
	weak_activable = true


func on_strong():
	strong_activable = true

	
func on_jump():
	jump_activable = true

	
func on_dash():
	dash_activable = true
	 
	
func start_skills():
	start_weak()
	start_strong()
	start_jump()
	start_dash()

	
func start_weak():
	weak_timer = Timer.new()
	weak_timer.set_one_shot(true)
	weak_timer.set_wait_time(weak_cooldown)
	weak_timer.connect("timeout", self, "on_weak")
	add_child(weak_timer)

	
func start_strong():
	strong_timer = Timer.new()
	strong_timer.set_one_shot(true)
	strong_timer.set_wait_time(strong_cooldown)
	strong_timer.connect("timeout", self, "on_strong")
	add_child(strong_timer)

	
func start_jump():
	jump_timer = Timer.new()
	jump_timer.set_one_shot(true)
	jump_timer.set_wait_time(jump_cooldown)
	jump_timer.connect("timeout", self, "on_jump")
	add_child(jump_timer)

	
func start_dash():
	dash_timer = Timer.new()
	dash_timer.set_one_shot(true)
	dash_timer.set_wait_time(dash_cooldown)
	dash_timer.connect("timeout",self,"on_dash")
	add_child(dash_timer)

	
func friction():
	if( velocity.x > 0):
		velocity.x -= friction_value
	if( velocity.x < 0):
		velocity.x += friction_value
	if(velocity.x > max_run_speed):
		velocity.x -= friction_value * 1.5
	if(velocity.x < -max_run_speed):
		velocity.x += friction_value * 1.5

		
# Standard Methods
func _ready():
	start_skills()

	
func _process(_delta):
	$hp.text = "HP: {hp}".format({"hp":current_hp})
	$lifeBar.value = current_hp
	get_input()

	
func _physics_process(delta):
	friction()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))
