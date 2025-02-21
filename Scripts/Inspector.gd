extends CharacterBody3D


@export var speed : float = 5.0
@export var accel : float = 10.0
@export var nav_path : Node
@export var evidences : Node

@onready var model = $Inspector_Model
@onready var look_timer : Timer = $look_around
@onready var nav : NavigationAgent3D = $NavigationAgent3D

var animplayer : AnimationPlayer
var nav_points : Array[Node]
var next_nav_point : Marker3D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var i : int
var look : bool
var direction_angle : float

func _ready():
	if nav_path:
		nav_points = nav_path.get_children()
		i = 0
		next_nav_point = nav_points[0]
		nav.target_position = next_nav_point.global_position
		look = false
	animplayer = model.get_node("AnimationPlayer")
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	#Rotate the body 4 times 90 degree each to inspect it's seroundings
	if look:
		velocity = Vector3.ZERO
	else:
		var direction = Vector3()
		if next_nav_point:
			nav.target_position = next_nav_point.global_position
		
			if nav.is_navigation_finished():
				i += 1
				
				if next_nav_point.is_in_group("look_point"):
					look = true
					look_timer.start()
				if i < nav_points.size():
					next_nav_point = nav_points[i]
				else:
					velocity.x = move_toward(velocity.x, 0, speed)
					velocity.z = move_toward(velocity.z, 0, speed)
					next_nav_point = null
					if Levels.lvl < len(Levels.lvls)-1:
						Levels.lvl += 1
					else:
						Levels.lvl = 0
					get_tree().change_scene_to_file(Levels.lvls[Levels.lvl])
				
			else:
				direction = nav.get_next_path_position() - global_position
				direction = direction.normalized()
				
				direction_angle = wrapf(atan2(direction.x, direction.z) - rotation.y, -PI, PI)
				rotation.y += clamp(delta*10.0, 0, abs(direction_angle)) * sign(direction_angle)
				if direction:
					velocity.x = lerpf(velocity.x, direction.x * speed, delta * accel)
					velocity.z = lerpf(velocity.z, direction.z * speed, delta * accel)
					
					velocity.x = direction.x * speed
					velocity.z = direction.z * speed
	if velocity != Vector3.ZERO:
		animplayer.play("Walk")
	else:
		animplayer.play("Still")
	move_and_slide()


func _on_look_around_timeout():
	look=false
