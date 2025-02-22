extends Node

var i: int

func unpause():
	get_tree().paused = false
	
func _on_next_level_pressed():
	unpause()
	i = Levels.lvl
	i += 1
	if i < Levels.lvls.size():
		Levels.lvl = i
	else : 
		Levels.lvl = 0
	get_tree().change_scene_to_file(Levels.lvls[Levels.lvl])


func _on_main_menu_pressed():
	unpause()
	Levels.lvl = 0
	get_tree().change_scene_to_file(Levels.lvls[Levels.lvl])


func _on_restart_pressed():
	unpause()
	get_tree().reload_current_scene()
