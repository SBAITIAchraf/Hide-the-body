extends Control

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_start_pressed():
	Levels.lvl = 1
	get_tree().change_scene_to_file(Levels.lvls[Levels.lvl])


func _on_exit_pressed():
	get_tree().quit()
