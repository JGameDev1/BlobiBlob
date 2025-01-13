extends CharacterBody2D
var NumberOfPower:int
@export_enum("R","G","B") var TypeOf:int
@export_enum("walk","run") var State:int
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
	if !DataManager.inDanger and moveCrono<=0:
		State=0
		lastPosRegistred=Vector2(randi_range(-2,2),randi_range(-2,2)).normalized()
		moveCrono=onMoveCronometre
	elif DataManager.inDanger and moveCrono<=0:
		State=1
		lastPosRegistred=Vector2(randi_range(-2,2),randi_range(-2,2))
		moveCrono=onMoveCronometre
	move_and_slide()

func _animations():
	if lastPosRegistred.x<0:$AnimatedSprite2D.flip_h=true
	else:$AnimatedSprite2D.flip_h=false
	match State:
		0:
			speed=20000
			if TypeOf==0:$AnimatedSprite2D.play("CientistRWalk")
			elif TypeOf==1:$AnimatedSprite2D.play("CientistGWalk")
			elif TypeOf==2:$AnimatedSprite2D.play("CientistBWalk")
		1:
			speed=30000
			if TypeOf==0:$AnimatedSprite2D.play("CientistRRun")
			elif TypeOf==1:$AnimatedSprite2D.play("CientistGRun")
			elif TypeOf==2:$AnimatedSprite2D.play("CientistBRun")
	$HLvlNumber.text=name

func _ready():
	TypeOf=randi_range(0,2)
	State=0
	NumberOfPower=randi_range(70,100)
	name=String.num_int64(NumberOfPower)
	moveCrono=onMoveCronometre
	limitNegX=(-limitPosX)
	limitNegY=(-limitPosY)

func _process(delta):
	_animations()
	_Limits()

func _physics_process(delta):
	_Movement(delta)
