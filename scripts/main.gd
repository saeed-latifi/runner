extends Node

var first_level = "res://scenes/levels/first_level.tscn"

@onready var settings_data = SettingLoader.settings_data
@onready var loaded_value  = $BoxContainer/VBoxContainer/HBoxContainer2/loaded
@onready var saved_value   = $BoxContainer/VBoxContainer/HBoxContainer2/saved
@onready var new_Text      = $BoxContainer/VBoxContainer/TextEdit

func _ready():
	SceneInfo.on_new_scene()

func _on_start_pressed():	
	get_tree().change_scene_to_file(first_level)

func _on_exit_pressed():
	get_tree().quit()

func _on_load_pressed():
	SettingLoader.load_settings()
	loaded_value.text = "%s" % [settings_data.base]

func _on_save_pressed():
	settings_data.base = new_Text.text
	SettingLoader.save_settings()
	saved_value.text = "%s" % [settings_data.base]
