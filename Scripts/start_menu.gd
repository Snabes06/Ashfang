extends Control

func _ready() -> void:
	$ColorRect/spin.play("spin")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape") and $ColorRect/Saves.visible == true:
		$ColorRect/Saves.hide()
		$ColorRect/Nav.show()
		$ColorRect/spin.show()

func _on_play_pressed() -> void:
	$ColorRect/Saves.show()
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
