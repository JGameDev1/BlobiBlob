extends CharacterBody2D
var NumberOfPower:int
@export_enum("Red","Green","Blue") var TypeOf:int
@export var onMoveCronometre=3.0
var moveCrono=3.0
var speed:float
var lastPosRegistred:Vector2
var limitNegX:float
@export_range(0,3840) var limitPosX:float
var limitNegY:float
@export_range(0,2160) var limitPosY:float

func _Limits():
	if global_position.x<limitNegX:global_position.x=limitNegX
	if global_position.x>limitPosX:global_position.x=limitPosX
	if global_position.y<limitNegY:global_position.y=limitNegY
	if global_position.y>limitPosY:global_position.y=limitPosY

func _Movement(d):
	moveCrono-=d
	velocity=lastPosRegistred*speed*d
	if moveCrono<=0:
		lastPosRegistred=Vector2(randi_range(-2,2),randi_range(-2,2)).normalized()
		moveCrono=onMoveCronometre
	move_and_slide()

func _animations():
	if lastPosRegistred.x<0:$AnimatedSprite2D.flip_h=true
	else:$AnimatedSprite2D.flip_h=false
	match TypeOf:
		0:$AnimatedSprite2D.play("CelR")
		1:$AnimatedSprite2D.play("CelG")
		2:$AnimatedSprite2D.play("CelB")

func _ready():
	TypeOf=randi_range(0,2)
	moveCrono=onMoveCronometre
	limitNegX=(-limitPosX)
	limitNegY=(-limitPosY)
	match TypeOf:
		0:
			NumberOfPower=randi_range(10,100)
			speed=80000
		1:
			speed=10000
			NumberOfPower=randi_range(0,1)
		2:
			speed=30000
			NumberOfPower=randi_range(2,51)
	name=String.num_int64(NumberOfPower)
	$CelLvl.text=name
func _process(delta):
	_animations()
	_Limits()
func _physics_process(delta):
	_Movement(delta)
