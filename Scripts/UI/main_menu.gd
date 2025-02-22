extends Control

@onready var settings = $Settings
@onready var levels = $LevelsList
@onready var first_page = $First_page
func _ready():
	settings.hide()
	levels.hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_start_pressed():
	Levels.lvl = 1
	get_tree().change_scene_to_file(Levels.lvls[Levels.lvl])


func _on_exit_pressed():
	get_tree().quit()


func _on_options_pressed():
	settings.show()


func _on_levels_pressed():
	levels.show()
