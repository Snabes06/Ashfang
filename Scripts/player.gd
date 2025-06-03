extends CharacterBody2D

@export var speed = 100
@export var level = 1
@onready var animation = $AnimatedSprite2D

func _ready() -> void:
	speed = GameManager.speed
	print(GameManager.player_pos)
	global_position = GameManager.player_pos
	level = GameManager.current_lvl

func _physics_process(delta: float) -> void:
	save()
	_inputs()
	_animate()
	move_and_slide()
	

func _inputs() -> void:
	if Input.is_action_just_pressed("test"):
		speed += 50
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	_walk(dir.normalized())

func _walk(dir: Vector2) -> void:
	velocity = dir * speed

func _animate() -> void:
	animation.play("idle_down")

func save() -> void:
	if Input.is_action_just_pressed("save"):
		GameManager.current_lvl = level
		GameManager.speed = speed
		GameManager.player_pos = global_position
		GameManager.save()
