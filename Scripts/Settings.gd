extends Control

@onready var volume_slid : Slider = $Panel/MarginContainer/VBoxContainer/Volume
@onready var mouse_sensetiv : Slider = $"Panel/MarginContainer/VBoxContainer/Mouse sens"

func _ready():
	volume_slid.value = GameSettings.volume
	mouse_sensetiv.value = GameSettings.mouse_sensetiv

func _on_volume_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)
	GameSettings.volume = volume_slid.value


func _on_mute_toggled(toggled_on):
	AudioServer.set_bus_mute(0, toggled_on)
	



func _on_mouse_sens_value_changed(value):
	GameSettings.mouse_sensetiv = mouse_sensetiv.value


func _on_screen_mode_item_selected(index):
	match index: 
		0: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		1: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		


func _on_screen_resolution_item_selected(index):
	match index:
		0: DisplayServer.window_set_size(Vector2i(1920, 1080))
		1: DisplayServer.window_set_size(Vector2i(1600, 900))
		2: DisplayServer.window_set_size(Vector2i(1366, 768))
		3: DisplayServer.window_set_size(Vector2i(1360, 768))
		4: DisplayServer.window_set_size(Vector2i(1280, 720))
