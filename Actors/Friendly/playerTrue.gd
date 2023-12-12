extends CharacterBody3D
@onready var camera_mount = $cameraMount
@onready var animation_player = $Player_model/AnimationPlayer

var done = false


const SPEED = 1000
const gravity_pull = 0.02
@export var sens_hor = 0.07
@export var sens_ver = 0.05

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

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
	
	upward(delta)
	downward(delta)

		
			
	
		#rotation.x = 25
	#if rotation.x != 0:
		#rotation.x -= 1
	var input_dir = Input.get_vector("left", "right", "up", "down")
	
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		
		#if velocity.x != 0:
		animation_player.play("CINEMA_4D_Principal")
		velocity.x = direction.x * SPEED*delta
		velocity.z = direction.z * SPEED*delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED*delta)
		velocity.z = move_toward(velocity.z, 0, SPEED*delta)

	move_and_slide()
	
func upward(delta):
	if Input.is_action_pressed("forward"):
		position.y += SPEED*delta*gravity_pull
func downward(delta):
	if Input.is_action_pressed("backward"):
		position.y -= SPEED*delta*gravity_pull
		

