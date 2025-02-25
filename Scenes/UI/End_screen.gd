extends Panel


func _on_menu_pressed():
	Levels.lvl = 0
	get_tree().change_scene_to_file(Levels.lvls[Levels.lvl].trim_suffix('.remap'))
