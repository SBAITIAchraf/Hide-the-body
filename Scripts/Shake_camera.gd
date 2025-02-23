extends Camera3D

var original_position: Vector3
var offset_distance := 0.3
var move_time := 6

func _ready() -> void:
	original_position = global_transform.origin
	start_random_offset_cycle()

func start_random_offset_cycle() -> void:
	var random_x = randf_range(-offset_distance, offset_distance)
	var random_y = randf_range(-offset_distance, offset_distance)
	var offset = Vector3(random_x, random_y, 0)

	var tween = get_tree().create_tween()
	
	# Step 1: Move camera from original_position to offset
	tween.tween_property(self, "global_transform:origin",
		original_position + offset, move_time
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	# Step 2: Move camera from offset back to original
	tween.tween_property(self, "global_transform:origin",
		original_position, move_time
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	# After finishing, call start_random_offset_cycle() again to repeat
	tween.tween_callback(Callable(self, "start_random_offset_cycle"))
