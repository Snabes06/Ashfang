extends Camera3D

@export var target_path: NodePath
@export var offset: Vector3 = Vector3(5, 8, 5)

var _target: Node3D

func _ready() -> void:
	_target = get_node(target_path) as Node3D
	if not _target:
		return
	rotation_degrees = Vector3(-40, 45, 0)

func _process(delta: float) -> void:
	if not _target:
		return
	global_transform.origin = _target.global_transform.origin + offset
