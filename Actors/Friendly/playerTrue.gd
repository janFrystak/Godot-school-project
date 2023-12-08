extends CharacterBody3D
@onready var camera_mount = $cameraMount
@onready var animation_player = $Player/AnimationPlayer



const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var sens_hor = 0.15
@export var sens_ver = 0.05

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad((-event.relative.x*sens_hor)))
		camera_mount.rotate_x(deg_to_rad(-event.relative.y*sens_ver))
	
func _process(delta):
	if Input.is_action_just_pressed("close"):
		get_tree().quit()
		
func _physics_process(delta):
	# Add the gravity.

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		
		if velocity.x != 0:
			animation_player.play("CINEMA_4D_Principal")
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
