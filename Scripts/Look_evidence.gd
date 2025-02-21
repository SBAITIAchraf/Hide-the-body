extends Node3D

@export var max_see_distance : float = 100000.0

@onready var detector : RayCast3D = $Detector
@onready var test : RayCast3D = $Test
@onready var inspector = $"../.."
@onready var eye = $"."
var evidences : Node3D
var evid_list : Array[Node]
var detected_evid : Array[Node3D]
var detect_points : Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	
	detector.enabled = false
	detector.rotation = - inspector.rotation
	evidences = inspector.evidences
	if evidences:
		evid_list = evidences.get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for evid in evid_list:
		detector.rotation = - inspector.rotation
		detect_points = evid.get_node("Detection points")
		var points = detect_points.get_children()
		for point in points:
			if can_see_evidence(evid, point):
				detected_evid.append(evid)
				print("EVIDENCE!")
		
	
func can_see_evidence(evid : Node, point : Node) -> bool:
	if detected_evid.has(evid):
		return false
		
	#Check distance
	var distance = global_position.distance_to(point.global_position)
	if distance > max_see_distance:
		return false
		
	#check FOV
	var forward = global_transform.basis.z
	var direction_to_object = (point.global_position - eye.global_position).normalized()
	var dot = forward.dot(direction_to_object)
	if dot < 0.25:
		return false
	# Check for obstacles
	detector.enabled = true
	detector.target_position = point.global_position - global_position
	
	detector.force_raycast_update()
	var collider = detector.get_collider()
	if collider == evid:
		return true
	else:
		return false
		
		
