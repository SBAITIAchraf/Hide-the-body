extends Node

@onready var parent_node := self

func _ready():
	var children_array = parent_node.get_children()
	for child in children_array:
		if child is MeshInstance3D:

			var collision_shape = CollisionShape3D.new()
			
			collision_shape.shape = child.mesh.create_trimesh_shape()
			collision_shape.transform = child.transform
			parent_node.add_child(collision_shape)
			
