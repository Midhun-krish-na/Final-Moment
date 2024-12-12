extends CharacterBody3D

var speed 
const Walk_SPEED = 1.5
const JUMP_VELOCITY = 2.5
const Sprint = 3
#Mouse movements
var _mouse_rotation : Vector3
var _rotation_input : float
var _tilt_input: float
var _mouse_input : bool = false
var _Player_rotation : Vector3
var _Camera_rotation : Vector3
#Bob variable
const Bob_freq = 6
const Bob_Amp = 0.05
var t_bob = 0.0
#FOV
const fov_base = 75.0
const fov_change = 1.5

@export var Mouse_sensitivity : float = 0.5
@export var Tilt_Lower_Limit := deg_to_rad(-90.0)
@export var Tilt_Upper_Limit := deg_to_rad(90.0)
@export var Camera_Controller : Camera3D


func _input(event):
	if event.is_action_pressed("Exit"):
		get_tree().quit()

func _unhandled_input(event):
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x * Mouse_sensitivity
		_tilt_input = -event.relative.y * Mouse_sensitivity

func _update_camera(delta):
	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, Tilt_Lower_Limit, Tilt_Upper_Limit)
	_mouse_rotation.y += _rotation_input * delta
	_Player_rotation = Vector3(0.0, _mouse_rotation.y, 0.0)
	_Camera_rotation = Vector3(_mouse_rotation.x, 0.0, 0.0)
	
	Camera_Controller.transform.basis = Basis.from_euler(_Camera_rotation)
	Camera_Controller.rotation.z = 0.0
	global_transform.basis = Basis.from_euler(_Player_rotation)
	_rotation_input = 0.0
	_tilt_input = 0.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	#Camera Updation
	_update_camera(delta)

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#HAndle sprint
	if Input.is_action_pressed("Sprint"):
		speed = Sprint
	else :
		speed = Walk_SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Move_Left", "Move_Right", "Move_Front", "Move_Back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x =lerp(velocity.x ,direction.x * speed, delta * 7.0)
			velocity.z =lerp(velocity.z ,direction.z * speed, delta * 7.0)
	else :
		velocity.x =lerp(velocity.x ,direction.x * speed, delta * 2.0)
		velocity.z =lerp(velocity.z ,direction.z * speed, delta * 2.0)
	#Head Bob
	t_bob += delta * velocity.length() * float(is_on_floor()) 
	Camera_Controller.transform.origin = _headbob(t_bob)
	
	#FOV
	var vel_clamped = clamp(velocity.length() , 0.5 , Sprint * 2.0)
	var target_fov = fov_base + fov_change * vel_clamped
	Camera_Controller.fov = lerp(Camera_Controller.fov, target_fov, delta * 8.0)

	move_and_slide()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * Bob_freq) * Bob_Amp
	pos.x = cos(time * Bob_freq / 2) * Bob_Amp
	return pos
