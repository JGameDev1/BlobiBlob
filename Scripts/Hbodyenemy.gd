extends CharacterBody2D
var speed:float
@export var lastPosRegistred:Vector2
var limitNegX:float
@export_range(0,3840) var limitPosX:float
@export_enum("V1","V2","V3","V4") var TypeOf:int

func _Movement(d):
	velocity=lastPosRegistred*speed*d
	if position.x<=limitNegX:lastPosRegistred.x=1
	elif position.x>=limitPosX:lastPosRegistred.x=-1
	move_and_slide()

func _animations():
	if lastPosRegistred.x<0:$AnimatedSprite2D.flip_h=true
	else:$AnimatedSprite2D.flip_h=false

func _ready():
	limitNegX=(-limitPosX)
	TypeOf=randi_range(0,4)
	lastPosRegistred.x=1
	match TypeOf:
		0:
			$AnimatedSprite2D.play("V1")
			speed=50000*randi_range(2,4)
		1:
			$AnimatedSprite2D.play("V2")
			speed=50000*randi_range(2,4)
		2:
			$AnimatedSprite2D.play("V3")
			speed=50000*randi_range(2,4)
		3:
			$AnimatedSprite2D.play("V4")
			speed=50000*randi_range(2,4)

func _process(delta):
	_animations()

func _physics_process(delta):
	_Movement(delta)
