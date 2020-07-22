extends VehicleBody

export var MAX_ENGINE_FORCE = 200.0
export var MAX_BRAKE_FORCE = 5.0
export var MAX_STEER_ANGLE = 0.5
export var STEER_SPEED = 1

export var steer_speed = 5.0

var steer_target = 0.0
var steer_angle = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	var fwd_mps = transform.basis.xform_inv(linear_velocity).x
	# overrules for keyboard
	if Input.is_action_pressed("ui_up"):
		engine_force = MAX_ENGINE_FORCE
	else:
		engine_force = 0.0
	if Input.is_action_pressed("ui_down"):
		if(fwd_mps >= -1):
			engine_force = -MAX_ENGINE_FORCE
		else:
			brake = 1
	else:
		brake = 0.0
	var steer_val = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	
	steer_target = steer_val * MAX_STEER_ANGLE
	print(steer_target)
	
	steering = move_toward(steering,steer_target,STEER_SPEED * delta)
	
