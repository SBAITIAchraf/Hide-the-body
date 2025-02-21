extends Control

@onready var anim_player : AnimationPlayer = $AnimationPlayer

func _ready():
	hide()
	anim_player.play("RESET")

func resume():
	get_tree().paused = false
	anim_player.play_backwards("blur")

func pause():
	get_tree().paused = true
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
	resume()


func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	testEsc()
