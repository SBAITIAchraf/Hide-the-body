extends Node

var lvls = []
var lvl = 0

var levels_folder = 'res://Scenes/Main Game/'
var dir = DirAccess.open(levels_folder)
	
   


func _ready():
	if dir:
		for file_name in dir.get_files():
			var full_path = levels_folder + file_name
			lvls.append(full_path)
