extends Node

@onready var parent_node := self

func _ready():
	var children_array = parent_node.get_children()
	for child in children_array:
		if child is MeshInstance3D:
			var rigid_body = RigidBody3D.new()
			rigid_body.transform = child.transform
			parent_node.add_child(rigid_body)
			
			child.get_parent().remove_child(child)
			rigid_body.add_child(child)

			var collision_shape = CollisionShape3D.new()
			
			collision_shape.shape = child.mesh.create_convex_shape()
			collision_shape.transform = child.transform
			rigid_body.add_child(collision_shape)
			
