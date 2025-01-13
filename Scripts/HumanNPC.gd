extends CharacterBody2D
var NumberOfPower:int
@export_enum("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15") var TypeOf:int
@export_enum("idle","walk","run","runScared") var State:int
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
		State=randi_range(0,2)
		lastPosRegistred=Vector2(randi_range(-2,2),randi_range(-2,2)).normalized()
		moveCrono=onMoveCronometre
	elif DataManager.inDanger and moveCrono<=0:
		State=3
		lastPosRegistred=Vector2(randi_range(-2,2),randi_range(-2,2))
		moveCrono=onMoveCronometre
	move_and_slide()

func _animations():
	if lastPosRegistred.x<0:$AnimatedSprite2D.flip_h=true
	else:$AnimatedSprite2D.flip_h=false
	match State:
		0:
			speed=0
			if TypeOf==0:$AnimatedSprite2D.play("Idle")
			elif TypeOf==1:$AnimatedSprite2D.play("Idle_1")
			elif TypeOf==2:$AnimatedSprite2D.play("Idle_2")
			elif TypeOf==3:$AnimatedSprite2D.play("Idle_3")
			elif TypeOf==4:$AnimatedSprite2D.play("Idle_4")
			elif TypeOf==5:$AnimatedSprite2D.play("Idle_5")
			elif TypeOf==6:$AnimatedSprite2D.play("Idle_6")
			elif TypeOf==7:$AnimatedSprite2D.play("Idle_7")
			elif TypeOf==8:$AnimatedSprite2D.play("Idle_8")
			elif TypeOf==9:$AnimatedSprite2D.play("Idle_9")
			elif TypeOf==10:$AnimatedSprite2D.play("Idle_10")
			elif TypeOf==11:$AnimatedSprite2D.play("Idle_11")
			elif TypeOf==12:$AnimatedSprite2D.play("Idle_12")
			elif TypeOf==13:$AnimatedSprite2D.play("Idle_13")
			elif TypeOf==14:$AnimatedSprite2D.play("Idle_14")
			elif TypeOf==15:$AnimatedSprite2D.play("Idle_15")
		1:
			speed=5000
			if TypeOf==0:$AnimatedSprite2D.play("Walk")
			elif TypeOf==1:$AnimatedSprite2D.play("Walk_1")
			elif TypeOf==2:$AnimatedSprite2D.play("Walk_2")
			elif TypeOf==3:$AnimatedSprite2D.play("Walk_3")
			elif TypeOf==4:$AnimatedSprite2D.play("Walk_4")
			elif TypeOf==5:$AnimatedSprite2D.play("Walk_5")
			elif TypeOf==6:$AnimatedSprite2D.play("Walk_6")
			elif TypeOf==7:$AnimatedSprite2D.play("Walk_7")
			elif TypeOf==8:$AnimatedSprite2D.play("Walk_8")
			elif TypeOf==9:$AnimatedSprite2D.play("Walk_9")
			elif TypeOf==10:$AnimatedSprite2D.play("Walk_10")
			elif TypeOf==11:$AnimatedSprite2D.play("Walk_11")
			elif TypeOf==12:$AnimatedSprite2D.play("Walk_12")
			elif TypeOf==13:$AnimatedSprite2D.play("Walk_13")
			elif TypeOf==14:$AnimatedSprite2D.play("Walk_14")
			elif TypeOf==15:$AnimatedSprite2D.play("Walk_15")
		2:
			speed=8000
			if TypeOf==0:$AnimatedSprite2D.play("Run")
			elif TypeOf==1:$AnimatedSprite2D.play("Run_1")
			elif TypeOf==2:$AnimatedSprite2D.play("Run_2")
			elif TypeOf==3:$AnimatedSprite2D.play("Run_3")
			elif TypeOf==4:$AnimatedSprite2D.play("Run_4")
			elif TypeOf==5:$AnimatedSprite2D.play("Run_5")
			elif TypeOf==6:$AnimatedSprite2D.play("Run_6")
			elif TypeOf==7:$AnimatedSprite2D.play("Run_7")
			elif TypeOf==8:$AnimatedSprite2D.play("Run_8")
			elif TypeOf==9:$AnimatedSprite2D.play("Run_9")
			elif TypeOf==10:$AnimatedSprite2D.play("Run_10")
			elif TypeOf==11:$AnimatedSprite2D.play("Run_11")
			elif TypeOf==12:$AnimatedSprite2D.play("Run_12")
			elif TypeOf==13:$AnimatedSprite2D.play("Run_13")
			elif TypeOf==14:$AnimatedSprite2D.play("Run_14")
			elif TypeOf==15:$AnimatedSprite2D.play("Run_15")
		3:
			speed=10000
			if TypeOf==0:$AnimatedSprite2D.play("RunScared")
			elif TypeOf==1:$AnimatedSprite2D.play("RunScared_1")
			elif TypeOf==2:$AnimatedSprite2D.play("RunScared_2")
			elif TypeOf==3:$AnimatedSprite2D.play("RunScared_3")
			elif TypeOf==4:$AnimatedSprite2D.play("RunScared_4")
			elif TypeOf==5:$AnimatedSprite2D.play("RunScared_5")
			elif TypeOf==6:$AnimatedSprite2D.play("RunScared_6")
			elif TypeOf==7:$AnimatedSprite2D.play("RunScared_7")
			elif TypeOf==8:$AnimatedSprite2D.play("RunScared_8")
			elif TypeOf==9:$AnimatedSprite2D.play("RunScared_9")
			elif TypeOf==10:$AnimatedSprite2D.play("RunScared_10")
			elif TypeOf==11:$AnimatedSprite2D.play("RunScared_11")
			elif TypeOf==12:$AnimatedSprite2D.play("RunScared_12")
			elif TypeOf==13:$AnimatedSprite2D.play("RunScared_13")
			elif TypeOf==14:$AnimatedSprite2D.play("RunScared_14")
			elif TypeOf==15:$AnimatedSprite2D.play("RunScared_15")
	$HLvlNumber.text=name

func _ready():
	TypeOf=randi_range(0,16)
	State=0
	NumberOfPower=randi_range(1,10)
	name=String.num_int64(NumberOfPower)
	moveCrono=onMoveCronometre
	limitNegX=(-limitPosX)
	limitNegY=(-limitPosY)

func _process(delta):
	_animations()
	_Limits()

func _physics_process(delta):
	_Movement(delta)
