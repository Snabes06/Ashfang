extends CharacterBody3D


@export var attack_effect: PackedScene = preload("res://Scenes/Attack Effects/slash_big.tscn")
@onready var speed = 100
var temp = Vector2(0, 0)
var level = 0

var tilt_angle = deg_to_rad(-45)
var dir = Vector3.ZERO
var is_dashing = false
var dash_timer = 0
var dash_cooldown = 0

func _ready() -> void:
	speed = GameManager.speed
	global_position = GameManager.player_pos
	level = GameManager.current_lvl

func _physics_process(delta: float) -> void:
	_inputs()
	_dash(delta)
	move_and_slide()

func _inputs() -> void:
	if is_dashing:
		return
	else:
		var untiled_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		dir = untiled_dir.rotated(tilt_angle)
		_move(dir)
		if Input.is_action_just_pressed("dash") and dash_cooldown <= 0:
			_start_dash()
		elif Input.is_action_just_pressed("attack"):
			_attack(dir)
		elif Input.is_action_just_pressed("save"):
			_save()

func _move(dir: Vector2) -> void:
	velocity = Vector3(dir.x, -9.82, dir.y).normalized() * speed
	if dir != Vector2.ZERO:
		$Skeleton/AnimationPlayer.play("Running_C")
		temp = dir.normalized().rotated(45)
		look_at(global_position + Vector3(velocity.x, 0, velocity.z), Vector3.UP, true)

func _start_dash() -> void:
	is_dashing = true
	dash_timer = 0.25
	dash_cooldown = 0.4
	velocity = Vector3(dir.x, 0, dir.y).normalized() * 25

func _dash(delta: float) -> void:
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			velocity = Vector3.ZERO
	if dash_cooldown > 0:
		dash_cooldown -= delta

func _attack(dir: Vector2) -> void:
	var instance = attack_effect.instantiate()
	add_child(instance)
	var attack_dir = global_position + Vector3(temp.x, 0, temp.y) * 2
	instance.get_child(0).global_position = attack_dir

func _save() -> void:
	GameManager.current_lvl = level
	GameManager.speed = speed
	GameManager.player_pos = global_position
	GameManager.save()
