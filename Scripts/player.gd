extends CharacterBody2D

@export var speed = 100
@onready var animation = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	_inputs()
	_animate()
	move_and_slide()
	

func _inputs() -> void:
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	_walk(dir.normalized())

func _walk(dir: Vector2) -> void:
	velocity = dir * speed

func _animate() -> void:
	animation.play("idle_down")
