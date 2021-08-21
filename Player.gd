extends KinematicBody2D

var curHP : int = 10
var maxHP : int = 10
var moveSpeed : int = 250
var damage : int = 1

var gold : int = 0
var curLevel : int = 0
var curXp : int = 0
var xpToNextLevel : int = 50
var xpToLevelIncreaseRate : float = 1.2

var interactist : int = 70

var vel : Vector2 = Vector2()
var facingDir : Vector2 = Vector2()

onready var rayCast = get_node("RayCast2D")



func _physics_process(delta):
	vel = Vector2()
	
	if Input.is_action_pressed("move_up"):
		vel.y -= 1
		facingDir = Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		vel.y += 1
		facingDir = Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		vel.y -= 1
		facingDir = Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		vel.y += 1
		facingDir = Vector2(1, 0)
