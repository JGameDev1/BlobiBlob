extends CharacterBody2D
var speed=80000
var Percent:int
signal Grown
signal Damage
var MyActualPower:int
var Idle=true
var limitNegX:float
@export_range(0,3840) var limitPosX:float
var limitNegY:float
@export_range(0,2160) var limitPosY:float

func _Limits():
	if global_position.x<=limitNegX:
		global_position.x=limitNegX
	if global_position.x>=limitPosX:
		global_position.x=limitPosX
	if global_position.y<=limitNegY:
		global_position.y=limitNegY
	if global_position.y>=limitPosY:
		global_position.y=limitPosY

func _movement(d):
	var AxisForTopDown=Input.get_vector("Left","Right","Up","Down").normalized()*speed*d
	velocity=AxisForTopDown
	if velocity==Vector2.ZERO:
		Idle=true
	else:Idle=false
	if typeof("Normal") and !Idle:
		$AnimatedSprite2D.play("OnMove",1)
	elif typeof("Normal") and Idle:$AnimatedSprite2D.play("Idle",0.3)
	move_and_slide()

func _ready():
	limitNegX=-limitPosX
	limitNegY=-limitPosY

func _physics_process(delta):
	_movement(delta)

func _on_area_2d_body_entered(body):
	$MyLvl.text=String.num_int64($"../BlobiCanvas/EvolveBar".scale.x)
	if body.name=="KillerBody":
		Damage.emit(100)
	elif body.name.to_int()<=$"../BlobiCanvas/EvolveBar".scale.x:
		body.queue_free()
		Grown.emit(2)
		$"../POP".play()
		if scale.x<2.5:scale+=Vector2(($"../BlobiCanvas/EvolveBar".scale.x-body.name.to_int())*0.1,($"../BlobiCanvas/EvolveBar".scale.x-body.name.to_int())*0.1)
	elif body.name.to_int()>=$"../BlobiCanvas/EvolveBar".scale.x:
		Damage.emit(1)
		scale-=Vector2(0.1,0.1)
		$"../Quejido".play()

func _process(delta):
	_Limits()
	$"../BlobiCam2D".global_position=Vector2(lerpf($"../BlobiCam2D".global_position.x,global_position.x,0.008),lerpf($"../BlobiCam2D".global_position.y,global_position.y,0.008))
	if $"../BlobiCanvas/EvolveBar".scale.x<=0:hide()
	if scale<Vector2(0.7,0.7):scale=Vector2(0.7,0.7)
	if scale>Vector2(2,2):scale=Vector2(2,2)
