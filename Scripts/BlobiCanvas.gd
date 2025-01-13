extends CanvasLayer
var ScenePaths=["res://Scenes/celular_world.tscn","res://Scenes/city.tscn","res://Scenes/city_2.tscn","res://Scenes/final_scene.tscn"]
func _BarBehaviour(d):
	if $EvolveBar.scale.x<=100 and $EvolveBar.scale.x>0:
		$EvolvePercent.text="% "+String.num_int64($EvolveBar.scale.x)
	elif $EvolveBar.scale.x<0:
		$GameOverIMG.show()
		$RetryLvlButton.show()
		$BlobiIMG.hide()
		$EvolvePercent.hide()
		$EvolveBar.hide()
		$RefBar.hide()
		$NextLvlButton.hide()
		$WinImg.hide()
	elif $EvolveBar.scale.x>=100:
		$GameOverIMG.hide()
		$RetryLvlButton.hide()
		$BlobiIMG.show()
		$EvolvePercent.show()
		$EvolveBar.show()
		$RefBar.show()
		$NextLvlButton.show()
		$WinImg.show()

func _ready():
	$EvolveBar.scale.x=1
	$"../BlobiBody/MyLvl".text=String.num_int64($"../BlobiCanvas/EvolveBar".scale.x)
	$WinImg.hide()
	$NextLvlButton.hide()
	$GameOverIMG.hide()
	$RetryLvlButton.hide()
	if DataManager.PC:$BaseJoystick.queue_free()

func _process(delta):
	_BarBehaviour(delta)

func _on_character_body_2d_grown(AbsorbedPoints):
	$EvolveBar.scale.x+=AbsorbedPoints
	$"../BlobiBody/MyLvl".text=String.num_int64($"../BlobiCanvas/EvolveBar".scale.x)
	DataManager.game_data_dict["Score"]+=1

func _on_character_body_2d_damage(AbsorbedPoints):
	if $EvolveBar.scale.x>0:$EvolveBar.scale.x-=AbsorbedPoints
	else:$EvolveBar.scale.x=0
	$"../BlobiBody/MyLvl".text=String.num_int64($"../BlobiCanvas/EvolveBar".scale.x)

func _on_next_lvl_button_pressed():
	DataManager.game_data_dict["LvlId"]+=1
	DataManager.DeleteCelularWorld=true
	DataManager.DeleteCity1=true
	DataManager.DeleteCity2=true
	$EvolveBar.scale.x=1
	$"../BlobiBody/MyLvl".text=String.num_int64($EvolveBar.scale.x)
	$"../BlobiBody".scale=Vector2(1,1)
	$GameOverIMG.hide()
	$RetryLvlButton.hide()
	$BlobiIMG.show()
	$EvolvePercent.show()
	$EvolveBar.show()
	$RefBar.show()
	$NextLvlButton.hide()
	$WinImg.hide()
	$"../BlobiBody".show()
	DataManager._SaveGame()
	get_tree().change_scene_to_file(ScenePaths[DataManager.game_data_dict["LvlId"]])

func _on_retry_lvl_button_pressed():
	$EvolveBar.scale.x=1
	$GameOverIMG.hide()
	$RetryLvlButton.hide()
	$BlobiIMG.show()
	$EvolvePercent.show()
	$EvolveBar.show()
	$RefBar.show()
	$NextLvlButton.hide()
	$WinImg.hide()
	$"../BlobiBody".show()
	$"../BlobiBody/MyLvl".text=String.num_int64($EvolveBar.scale.x)

func _on_x_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	DataManager.DeleteCelularWorld=true
	DataManager.DeleteCity1=true
	DataManager.DeleteCity2=true
	$"..".queue_free()
