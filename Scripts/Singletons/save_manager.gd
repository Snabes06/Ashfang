extends Node
class_name save_manager

var current_data: Dictionary = {}

const SAVE_DIR := "user://saves/"
const FILE_EXTENSION := ".json"

func _ready():
	var dir := DirAccess.open("user://")
	if not dir.dir_exists(SAVE_DIR):
		DirAccess.make_dir_absolute(SAVE_DIR)

func save_game(slot: int) -> void:
	var path := SAVE_DIR + "save_" + str(slot) + FILE_EXTENSION
	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(current_data, "\t"))
	file.close()
	print("Game saved to", path)

func load_game(slot: int) -> bool:
	var path := SAVE_DIR + "save_" + str(slot) + FILE_EXTENSION
	if not FileAccess.file_exists(path):
		print("Save file not found:", path)
		return false

	var file := FileAccess.open(path, FileAccess.READ)
	var content := file.get_as_text()
	file.close()

	var result = JSON.parse_string(content)
	if typeof(result) == TYPE_DICTIONARY:
		current_data = result
		print("Loaded save data from", path)
		return true
	else:
		print("Failed to parse save file:", path)
		return false

func delete_save(slot: int) -> void:
	var path := SAVE_DIR + "save_" + str(slot) + FILE_EXTENSION
	if FileAccess.file_exists(path):
		DirAccess.remove_absolute(path)
		print("Deleted save file:", path)

func list_saves() -> Array:
	var saves: Array = []
	var dir := DirAccess.open(SAVE_DIR)
	if dir:
		for file_name in dir.get_files():
			if file_name.ends_with(FILE_EXTENSION):
				saves.append(file_name)
	return saves
