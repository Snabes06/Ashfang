extends Button

@onready var animation = $AnimationPlayer
@export var label = "Placeholder"

func _ready() -> void:
	text = label

func _on_mouse_entered() -> void:
	animation.play("hover_enter")


func _on_mouse_exited() -> void:
	animation.play("hover_exit")
