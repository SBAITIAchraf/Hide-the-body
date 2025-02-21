extends Node

var i: int


func _on_next_level_pressed():
	i = Levels.lvl
	i += 1
	if i < Levels.lvls.size():
		Levels.lvl = i
	else : 
		Levels.lvl = 0
	get_tree().change_scene_to_file(Levels.lvls[Levels.lvl])
