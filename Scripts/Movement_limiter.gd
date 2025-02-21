extends RigidBody3D

@export var Z: bool
@export var minZ: float = 0
@export var maxZ : float = 1

func _physics_process(delta):
	var pos = transform.basis
	# Clamp z
	pos.z.z = clamp(pos.z.z, minZ, maxZ)
	# Reassign the transform
	var my_transform = transform
	my_transform.basis = pos
	transform = my_transform
