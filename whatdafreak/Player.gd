extends CharacterBody3D
class_name PlayerClass


@onready var JumpTimer = $JumpTimer
# cam vars
@onready var Head = $Head
var min_cam_angle : float = -90.0
var max_cam_angle : float = 90.0
var mouse_delta = Vector2()
var sense = 8.0

# stat vars
const speed = 25.0
var jumps_left = 2
const jump = 15.5
const gravity = 30.0
var hp = 100
const max_hp = 150
var armour = 0
const max_armour = 100
var exp=1 #speed multiplier for dashes


func _physics_process(delta):
	# jump
	if Input.is_action_just_pressed("ui_accept"):
		if jumps_left != 0:
			velocity.y = jump
			jumps_left -= 1
			
		
	
	var input_dir = Input.get_vector("moveleft", "moveright", "moveup", "movedown")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	if Input.is_action_just_pressed("dash"):
		exp = 30
		velocity.x = direction.x *speed*exp
		velocity.z = direction.z *speed*exp
	else:
		exp = 1
	
	if !is_on_floor():
		velocity.y -= gravity * delta
	
	move_and_slide()

func _process(delta):
	Head.rotation_degrees.x -= mouse_delta.y * sense * delta
	
	Head.rotation_degrees.x = clamp(Head.rotation_degrees.x, min_cam_angle, max_cam_angle)
	
	rotation_degrees.y -= mouse_delta.x * sense * delta
	
	Head.rotation_degrees.y = clamp(Head.rotation_degrees.y, min_cam_angle, max_cam_angle)
	
	mouse_delta = Vector2()
	

func _input(event):
	if event is InputEventMouseMotion:
		mouse_delta = event.relative
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_jump_timer_timeout():
	print("can double jump now")
	if is_on_floor():
		jumps_left = 2
