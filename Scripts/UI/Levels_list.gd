extends Control

@onready var LevelList = $Panel/MarginContainer/VBoxContainer/ScrollContainer/LevelslistCont
@onready var level_button = preload("res://Scenes/UI/level_button.tscn")

func _ready():
	var i = 1
	
	for item in LevelList.get_children():
		item.queue_free()
	for thing in range(Levels.lvls.size()):
		print(Levels.lvls[0])
	for j in range(Levels.lvls.size()):
		if j != 0 && j != Levels.lvls.size()-1:
			var button = level_button.instantiate()
			button.text = "Level " + str(i)
			i += 1
			LevelList.add_child(button)
			button.pressed.connect(_on_button_pressed.bind(Levels.lvls[j]))


func _on_button_pressed(scene_path: String):
	# Loads/changes to the scene associated with the path
	get_tree().change_scene_to_file(scene_path)


func _on_close_pressed():
	get_parent().first_page.show()
	hide()
