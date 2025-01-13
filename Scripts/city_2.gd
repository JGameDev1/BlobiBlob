extends Node2D
@export var RespawnerPoints:PackedVector2Array
var obj=load("res://Scenes/HumanNPC.tscn")

func _ready():
	DataManager.DeleteCity2=false
	RespawnerPoints[0]=$Mark1.position
	RespawnerPoints[1]=$Mark2.position
	RespawnerPoints[2]=$Mark3.position
	RespawnerPoints[3]=$Mark4.position
	RespawnerPoints[4]=$Mark5.position
	RespawnerPoints[5]=$Mark6.position
	RespawnerPoints[6]=$Mark7.position
	RespawnerPoints[7]=$Mark8.position
	DataManager.inDanger=false

func _on_respawn_timer_timeout():
	var e=obj.instantiate()
	add_child(e)
	e.position=RespawnerPoints[randi_range(0,7)]

func _on_in_danger_timer_timeout():
	DataManager.inDanger=true

func _process(delta):
	if DataManager.DeleteCity2:
		self.queue_free()


func _on_music_city_2_finished():
	$MusicCity2.play()
