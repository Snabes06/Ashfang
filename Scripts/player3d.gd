extends CharacterBody3D


@export var attack_effect: PackedScene = preload("res://Scenes/Attack Effects/slash_big.tscn")
var speed = 5
var temp = Vector2(0, 0)
var timer = 2

func _physics_process(delta: float) -> void:
	_inputs()
	move_and_slide()

func _inputs() -> void:
	var untiled_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var tilt_angle := deg_to_rad(-45)
	var dir := untiled_dir.rotated(tilt_angle)
	if Input.is_action_just_pressed("attack"):
		_attack(dir)
	_move(dir)

func _move(dir: Vector2) -> void:
	velocity = Vector3(dir.x, -9.82, dir.y) * speed
	if dir != Vector2.ZERO:
		temp = dir.normalized().rotated(45)
		look_at(global_position + velocity)

func _attack(dir: Vector2) -> void:
	var instance = attack_effect.instantiate()
	add_child(instance)
	var attack_dir = global_position + Vector3(temp.x, 0, temp.y) * 2
	instance.get_child(0).global_position = attack_dir
