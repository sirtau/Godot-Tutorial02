extends KinematicBody2D

var curHp : int = 10
var maxHp : int = 10
var moveSpeed : int = 250
var damage : int = 3

var gold : int = 0
var curLevel : int = 0
var curXp : int = 0
var xpToNextLevel : int = 50
var xpToLevelIncreaseRate : float = 1.2

var interactDist : int = 70

var vel : Vector2 = Vector2()
var facingDir : Vector2 = Vector2()

onready var rayCast = get_node("RayCast2D")
onready var anim = get_node("AnimatedSprite")


func _physics_process(delta):
	vel = Vector2()
	
	if Input.is_action_pressed("move_up"):
		vel.y -= 1
		facingDir = Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		vel.y += 1
		facingDir = Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		vel.x -= 1
		facingDir = Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		vel.x += 1
		facingDir = Vector2(1, 0)
	
	vel = vel.normalized()
	
	move_and_slide(vel * moveSpeed)
	manage_animations()

func manage_animations():
	if vel.x > 0:
		play_animation("MoveRight")
	elif vel.x < 0:
		play_animation("MoveLeft")
	elif vel.y < 0:
		play_animation("MoveUp")
	elif vel.y > 0:
		play_animation("MoveDown")	
	elif facingDir.x == 1:
		play_animation("IdleRight")
	elif facingDir.x == -1:
		play_animation("IdleLeft")
	elif facingDir.y == -1:
		play_animation("IdleUp")
	elif facingDir.y == 1:
		play_animation("IdleDown")

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		try_interact()

func try_interact():
	rayCast.cast_to = facingDir * interactDist
	
	if rayCast.is_colliding():
		if rayCast.get_collider() is KinematicBody2D:
			rayCast.get_collider().take_damage(damage)
		elif rayCast.get_collider().has_method("on_interact"):
			rayCast.get_collider().on_interact(self)

func play_animation(anim_name):
	if anim.animation != anim_name:
		anim.play(anim_name)

func give_xp(amount):
	curXp += amount
	
	if curXp >= xpToNextLevel:
		level_up()

func level_up():
	var overflowXp = curXp - xpToNextLevel
	xpToNextLevel *= xpToLevelIncreaseRate
	curXp = overflowXp
	curLevel += 1

func take_damage(dmgToTake):
	curHp -= dmgToTake
	
	if curHp <= 0:
		die()

func die():
	get_tree().reload_current_scene()
	


