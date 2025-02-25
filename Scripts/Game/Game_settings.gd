extends Node

var mouse_sensetiv : float = 0.1
var volume = AudioServer.get_bus_volume_db(0)

var default_input_actions = {
	"move_forward" : KEY_W,
	"move_backward" : KEY_S,
	"move_right" :KEY_D,
	"move_left" : KEY_A,
	"action_jump" : KEY_SPACE,
	"action_sprint" : KEY_SHIFT,
	"grab" : MOUSE_BUTTON_LEFT,
}

var input_actions = {
	"move_forward" : null,
	"move_backward" : null,
	"move_right" :null,
	"move_left" : null,
	"action_jump" : null,
	"action_sprint" : null,
	"grab" : null,
}

func _ready():
	for action in input_actions:
		default_input_actions[action] = InputMap.action_get_events(action)[0]
		if input_actions[action]:
			var events = InputMap.action_get_events(action)
			if events.size() > 0 && events[0] != input_actions[action]:
				InputMap.action_erase_events(action)
				InputMap.action_add_event(action, input_actions[action])
				
				
func _process(delta):
	for action in input_actions:
		if input_actions[action]:
			var events = InputMap.action_get_events(action)
			if events.size() > 0 && events[0] != input_actions[action]:
				InputMap.action_erase_events(action)
				InputMap.action_add_event(action, input_actions[action])
