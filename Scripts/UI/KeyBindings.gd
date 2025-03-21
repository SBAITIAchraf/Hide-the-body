extends Control

@onready var input_buttn_scen = preload("res://Scenes/UI/input_button.tscn")

@onready var action_list = $"Panel/MarginContainer/VBoxContainer/ScrollContainer/Action List"

var is_remapping = false
var action_to_remap = null
var remappin_button = null

var input_actions = {
	"move_forward" : "Move Forward",
	"move_backward" : "Move Backward",
	"move_right" : "Move Right",
	"move_left" : "Move Left",
	"action_jump" : "Jump",
	"action_sprint" : "Sprint",
	"grab" : "Grab Objects",
}

func _ready():
	_create_action_list()

func _create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
	for action in input_actions:
		var button = input_buttn_scen.instantiate()
		var action_label = button.find_child('LabelAcion')
		var input_action = button.find_child("Action Input")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			if GameSettings.input_actions[action]:
				input_action.text = GameSettings.input_actions[action].as_text().trim_suffix(" (Physical)")
			else:
				input_action.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_action.text = ""
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))

func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remappin_button = button
		button.find_child("Action Input").text = "Press Key to bind..."
		
func _input(event):
	if is_remapping:
		if (event is InputEventKey || (event is InputEventMouseButton && event.is_pressed())):
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			
			GameSettings.input_actions[action_to_remap] = event
			#InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remappin_button, event)
			is_remapping = false
			action_to_remap = null
			remappin_button = null 
			
			accept_event()
			
func _update_action_list(button, event):
	button.find_child("Action Input").text = event.as_text().trim_suffix(" (Physical)")

func _on_close_pressed():
	get_parent().first_page.show()
	hide()


func _on_default_pressed():
	for action in input_actions:
		GameSettings.input_actions[action] = GameSettings.default_input_actions[action]
	_create_action_list()
