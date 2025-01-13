extends Control
var ScenePaths=["res://Scenes/celular_world.tscn","res://Scenes/city.tscn","res://Scenes/city_2.tscn"]
var A:float

func _on_x_button_pressed():
	if $BlobIMG.z_index==2:
		get_tree().quit()

func _on_creds_button_pressed():
	if $CredsIMG.z_index!=2:
		$BlobIMG.z_index=1
		$EarthIMG.z_index=0
		$CredsIMG.z_index=2
		$BackButton.z_index=2

func _on_back_button_pressed():
	if $CredsIMG.z_index==2:
		$BlobIMG.z_index=2
		$EarthIMG.z_index=1
		$CredsIMG.z_index=0
		$BackButton.z_index=0

func _on_play_button_pressed():
	if $BlobIMG.z_index==2:
		var LvlToLoad=load(ScenePaths[0]).instantiate()
		get_tree().root.add_child(LvlToLoad)
		self.queue_free()

func _ready():
	$BlobIMG.z_index=2
	$EarthIMG.z_index=1
	$CredsIMG.z_index=0
	$BackButton.z_index=0
	$BlobIMG.modulate=Color(1,1,1,0)
	if FileAccess.file_exists(DataManager.save_path):
		DataManager._LoadGame()
		$BlobIMG/LoadGameButton.disabled=false
	$BlobIMG/TotalScore.text="Record: "+String.num_int64(DataManager.game_data_dict["Score"])
	DataManager.DeleteCelularWorld=false
	DataManager.DeleteCity1=false
	DataManager.DeleteCity2=false

func _process(delta):
	A+=0.5*delta
	$BlobIMG.modulate=Color(1,1,1,A)
	if DataManager.ESP and !DataManager.ENG:
		$BlobIMG/NewGameButton.text="Nuevo Juego"
		$BlobIMG/LoadGameButton.text="Cargar Juego"
		$BlobIMG/CredsButton.text="Créditos"
	elif DataManager.ENG and !DataManager.ESP:
		$BlobIMG/NewGameButton.text="New Game"
		$BlobIMG/LoadGameButton.text="Load Game"
		$BlobIMG/CredsButton.text="Credits"
	if DataManager.PC:$BlobIMG/ModeButton.text="PC"
	else:$BlobIMG/ModeButton.text="Cel"

func _on_load_game_button_pressed():
	if !$BlobIMG/LoadGameButton.disabled and $BlobIMG.z_index==2:
		var LvlToLoad=load(ScenePaths[DataManager.game_data_dict["LvlId"]]).instantiate()
		get_tree().root.add_child(LvlToLoad)
		self.queue_free()

func _on_languaje_button_pressed():
	if DataManager.ESP and !DataManager.ENG:
		DataManager.ESP=false
		DataManager.ENG=true
	elif !DataManager.ESP and DataManager.ENG:
		DataManager.ESP=true
		DataManager.ENG=false


func _on_mode_button_pressed():
	if DataManager.PC:DataManager.PC=false
	elif !DataManager.PC:DataManager.PC=true
