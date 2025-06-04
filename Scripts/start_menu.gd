extends Control

func _ready() -> void:
	$ColorRect/spin.play("spin")
	for i in 3:
		if SaveManager.load_game(i):
			var data = SaveManager.current_data
			match(i):
				1:
					$ColorRect/Saves/Save1.text = "Save 1\n\nPlaytime: "+get_play_time_formatted(data["total_play_time"])
					break
				2:
					$ColorRect/Saves/Save2.text = "Save 2\n\nPlaytime: "+get_play_time_formatted(data["total_play_time"])
					break
				3:
					$ColorRect/Saves/Save3.text = "Save 3\n\nPlaytime: "+get_play_time_formatted(data["total_play_time"])
					break
				_:
					break

func get_play_time_formatted(time: int) -> String:
	var secs = time
	var hours = secs / 3600
	var mins = (secs % 3600) / 60
	var s = secs % 60
	return str(hours).pad_zeros(2) + ":" + str(mins).pad_zeros(2) + ":" + str(s).pad_zeros(2)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape") and $ColorRect/Saves.visible == true:
		$ColorRect/Saves.hide()
		$ColorRect/Info.hide()
		$ColorRect/Nav.show()
		$ColorRect/spin.show()

func _on_play_pressed() -> void:
	$ColorRect/Saves.show()
	$ColorRect/Info.show()
	$ColorRect/Nav.hide()
	$ColorRect/spin.hide()

func _on_exit_pressed() -> void:
	get_tree().quit(0)

func _open_save(i: int):
	if SaveManager.load_game(i):
		var data = SaveManager.current_data
		GameManager._load(data)
		GameManager.current_save = i
		
		get_tree().change_scene_to_file("res://Scenes/hub.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/hub.tscn")
