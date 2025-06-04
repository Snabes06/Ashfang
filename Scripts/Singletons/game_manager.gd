extends Node
class_name game_manager

var current_save = 0

var current_lvl = 1
var currency = 0
var hp = 500
var speed = 100
var player_pos = Vector2.ZERO
var session_start_time = 0
var total_play_time = 0

func _update_session_play_time() -> void:
	var now = Time.get_unix_time_from_system()
	var elapsed = now - session_start_time
	if elapsed > 0:
		total_play_time += elapsed
		session_start_time = now

func save() -> void:
	
	_update_session_play_time()
	
	SaveManager.current_data = {
		"current_lvl": current_lvl,
		"currency": currency,
		"hp": hp,
		"speed": speed,
		"player_pos": player_pos,
		"total_play_time": total_play_time
	}
	SaveManager.save_game(current_save)

func _load(data: Dictionary) -> void:
	currency = data["currency"]
	current_lvl = data["current_lvl"]
	hp = data["hp"]
	speed = data["speed"]
	total_play_time = data["total_play_time"]
	
	var new_string = data["player_pos"]
	new_string = new_string.erase(0, 1)
	new_string = new_string.erase(new_string.length() - 1, 1)
	var array = new_string.split(", ")

	player_pos = Vector2(int(array[0]), int(array[1]))
	
	session_start_time = Time.get_unix_time_from_system()
