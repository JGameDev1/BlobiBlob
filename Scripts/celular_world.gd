extends Node2D
@export var RespawnerPoints:PackedVector2Array
var obj=load("res://Scenes/CelNPC.tscn")

func _ready():
	DataManager.inDanger=false
	RespawnerPoints[0]=$Mark1.position
	RespawnerPoints[1]=$Mark2.position
	RespawnerPoints[2]=$Mark3.position
	RespawnerPoints[3]=$Mark4.position
	RespawnerPoints[4]=$Mark5.position
	RespawnerPoints[5]=$Mark6.position
	RespawnerPoints[6]=$Mark7.position
	RespawnerPoints[7]=$Mark8.position
	if DataManager.ENG and !DataManager.ESP:$Instrucciones.text="Eat everything that has a number less than or equal to yours
Devour the world Blobi!"
	if !DataManager.ENG and DataManager.ESP:$Instrucciones.text="Come todo lo que tenga un número menor o igual al tuyo
¡Devora al mundo Blobi!"

func _on_respawn_timer_timeout():
	var e=obj.instantiate()
	add_child(e)
	e.position=RespawnerPoints[randi_range(0,7)]

func _process(delta):
	if DataManager.DeleteCelularWorld:
		self.queue_free()

func _on_text_timer_timeout():
	$Instrucciones.hide()

func _on_music_celular_world_finished():
	$MusicCelularWorld.play()


func _on_water_sound_finished():
	$WaterSound.play()
