extends Control

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var settings = $Settings
@onready var first_page = $First_page

func _ready():
	settings.hide()
	hide()
	anim_player.play("RESET")

func resume():
	get_tree().paused = false
	settings.hide()
	anim_player.play_backwards("blur")

func pause():
	get_tree().paused = true
	first_page.show()
	anim_player.play("blur")

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pause()
		show()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		resume()
		
		hide()


func _on_resume_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	resume()


func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	testEsc()


func _on_options_pressed():
	first_page.hide()
	settings.show()


func _on_main_menu_pressed():
	Levels.lvl = 0
	get_tree().change_scene_to_file(Levels.lvls[Levels.lvl])
