extends CharacterBody2D
@onready var body = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var on_floor = true

var velocity_z = 0.0

@onready var position_x_2d = position.x

@onready var position_y_2d = position.y

var position_z = 0

func _physics_process(delta):
	# Add the gravity.
	if not on_floor:
		velocity_z += gravity * delta
		position_z += velocity_z * 0.01
	if position_z >= 0:
		on_floor = true
		position_z = 0
		velocity_z = 0

	# Handle jump.
	if Input.is_action_just_pressed("跳") and on_floor:
		print("跳")
		velocity_z = JUMP_VELOCITY
		on_floor = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("左", "右")
	velocity.x = direction_x * SPEED
	var direction_y = Input.get_axis("上", "下")
	velocity.y = direction_y * SPEED
	
	if Input.is_action_just_pressed("上"):
		body.play("背面" if on_floor else "背面跳")
	if Input.is_action_just_pressed("下"):
		body.play("正面" if on_floor else "正面跳")
	if Input.is_action_just_pressed("左"):
		body.play("朝左" if on_floor else "朝左跳")
	if Input.is_action_just_pressed("右"):
		body.play("朝右" if on_floor else "朝右跳")

	#move_and_slide()
	position_x_2d += velocity.x * 0.01
	position_y_2d += velocity.y * 0.01
	
	
	position.x = position_x_2d
	position.y = position_y_2d + position_z 
