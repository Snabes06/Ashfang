extends Node3D

var timer = 0.3

func _ready() -> void:
	$CPUParticles3D.emitting = true

func _physics_process(delta: float) -> void:
	timer -= delta
	rotate_z(0.15)
	if timer <= 0:
		queue_free()
