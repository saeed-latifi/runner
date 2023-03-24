extends Node2D

const PROJECT_DIRECTORY := "C:/runner"
const SAVED_SETTINGS_FILE_Path := PROJECT_DIRECTORY + "/saved_settings.txt"
var settings_data: Dictionary 

const DEFAULT_SETTINGS = {
	"base": 1,
	"active": false,
}

func _ready():
	if not DirAccess.dir_exists_absolute(PROJECT_DIRECTORY):
		var dir_access = DirAccess.open("C:/")
		dir_access.make_dir("runner")
	load_settings()

func save_settings() -> void:
	var setting_file =  FileAccess.open(SAVED_SETTINGS_FILE_Path,FileAccess.WRITE)
	setting_file.store_var(settings_data)
	setting_file.close()

func load_settings() -> void:
	if not FileAccess.file_exists(SAVED_SETTINGS_FILE_Path):
		settings_data = DEFAULT_SETTINGS
		save_settings()
		
	var setting_file =  FileAccess.open(SAVED_SETTINGS_FILE_Path,FileAccess.READ)
	settings_data = setting_file.get_var()
	setting_file.close()



