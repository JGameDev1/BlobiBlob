extends Control

@export var MainMenuScene=preload("res://Scenes/main_menu.tscn").instantiate()
func _ready():
	if DataManager.ESP and !DataManager.ENG:
		$AnimationPlayer.play("FinalSceneAnimESP")
	elif DataManager.ENG and !DataManager.ESP:
		$AnimationPlayer.current_animation("FinalSceneAnimENG")
		$AnimationPlayer.play()

func _on__pressed():
	get_tree().root.add_child(MainMenuScene)
	queue_free()
