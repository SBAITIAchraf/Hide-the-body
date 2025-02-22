extends Node3D

@onready var inpector_scene = preload("res://Scenes/Inspector.tscn")
@onready var first_timer: Timer = $before_spawn
@onready var second_timer: Timer = $Inspector_spawn
@onready var time_label: Label = $CanvasLayer/Time/Time_label

@export var inpect_spawn : Marker3D
@export var spawn_timer : Timer
@export var time_before_spawn : Timer

@export var nav_path : Node
@export var evidences : Node
@export var fail_level_screen : Control
@export var succeed_level_screen : Control

func _process(delta: float) -> void:
	if not first_timer.is_stopped():
		var seconds_left = int(first_timer.time_left)
		var minutes = seconds_left / 60
		var seconds = seconds_left % 60
		# Format the time as "M:SS"
		time_label.text = str(minutes) + ":" + str(seconds).pad_zeros(2)
	else:
		if not second_timer.is_stopped():
			var seconds_left = int(second_timer.time_left)
			var minutes = seconds_left / 60
			var seconds = seconds_left % 60
			# Format the time as "M:SS"
			time_label.text = str(minutes) + ":" + str(seconds).pad_zeros(2)
		else:
			time_label.text = "TIME'S UP!"

func _ready():
	succeed_level_screen.hide()
	fail_level_screen.hide()
	time_before_spawn.timeout.connect(_on_before_timer_stop)
	spawn_timer.timeout.connect(_on_spawn_timer_stop)
	time_before_spawn.start()



	
func _on_before_timer_stop():
	spawn_timer.start()
	
func _on_spawn_timer_stop():
	var inspector = inpector_scene.instantiate()
	inspector.position = inpect_spawn.position
	inspector.nav_path = nav_path
	inspector.evidences = evidences
	inspector.fail_level_screen = fail_level_screen
	inspector.succeed_level_screen = succeed_level_screen
	add_child(inspector)
