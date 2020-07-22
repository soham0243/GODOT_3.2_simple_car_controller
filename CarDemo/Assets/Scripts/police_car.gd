extends VehicleBody

export var MAX_ENGINE_FORCE = 200.0
export var MAX_BRAKE_FORCE = 5.0
export var MAX_STEER_ANGLE = 0.5

export var steer_speed = 5.0

var steer_target = 0.0
var steer_angle = 0.0

export var JOY_STEERING = JOY_ANALOG_LX
export var steering_mult = -1.0
export var JOY_THROTTLE = JOY_ANALOG_R2
export var throttle_mult = 1.0
export var JOY_BRAKE = JOY_ANALOG_L2
export var brake_mult = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	var steer_val = steering_mult * Input.get_joy_axis(0,JOY_STEERING)
	var throttle_val = throttle_mult * Input.get_joy_axis(0,JOY_THROTTLE)
	var brake_val = brake_mult * Input.get_joy_axis(0,JOY_BRAKE)
	# overrules for keyboard
	if Input.is_action_pressed("ui_up"):
		throttle_val = 1.0
	if Input.is_action_pressed("ui_down"):
		#brake_val = 1.0
		throttle_val = -1.0
	if Input.is_action_pressed("ui_left"):
		print("left arrow pressed")
		steer_val = 1.0
	if Input.is_action_pressed("ui_right"):
		print("right arrow pressed")
		steer_val = -1.0
		
	engine_force = throttle_val * MAX_ENGINE_FORCE
	brake = brake_val * MAX_BRAKE_FORCE
	
	steer_target = steer_val * MAX_STEER_ANGLE
	if(steer_target < steer_angle):
		steer_angle -= steer_target * delta
		if(steer_target > steer_angle):
			steer_angle = steer_target
	elif(steer_target > steer_angle):
		steer_angle += steer_target * delta
		if(steer_target < steer_angle):
			steer_angle = steer_target
		
	steering = steer_angle
	
