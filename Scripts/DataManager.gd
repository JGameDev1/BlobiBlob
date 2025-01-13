extends Node
var save_path="user://SaveGame.dat"
var inDanger=false
var DeleteCelularWorld=false
var DeleteCity1=false
var DeleteCity2=false
var ENG=false
var ESP=true
var game_data_dict={"Score":0,"LvlId":0}
var PC:bool=true

func _SaveGame():
	var save_file=FileAccess.open(save_path,FileAccess.WRITE)
	save_file.store_var(game_data_dict)
	save_file=null

func _LoadGame():
	if(FileAccess.file_exists(save_path)):
		var save_file=FileAccess.open(save_path,FileAccess.READ)
		save_file.get_var()
		save_file=null
