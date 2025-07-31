extends CharacterBody3D

@export var hasBullet = true
var SPEED = 15.0
const JUMP_VELOCITY = 7
signal hasAmmo
signal hasNoAmmo

func setCamFOV(newFOV):
	$Camera3D.fov = newFOV
	
func gunPosADS():
	$Camera3D/Gun.position = Vector3(0,-0.12,-0.4) 
	$Camera3D/Gun.rotation.y = PI
func gunPosStd():
	$Camera3D/Gun.position = Vector3(0.33,-0.15,-0.4)
	$Camera3D/Gun.rotation.y = PI * (-19/18)
func _physics_process(delta: float) -> void:
	# Add the gravity.
	var mouse_pos = get_viewport().get_mouse_position()
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("SLeft", "SRight", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()

func turnCamera(delta):
	if $Camera3D.rotation.x - delta < PI / 2 && $Camera3D.rotation.x - delta > -PI / 2:
		$Camera3D.rotate_x(-delta)

func _ready():
	pass

func fireShot() -> void:
	pass
	#emit_signal("playerHasNoAmmo")
	#$Camera3D/RayCast3D.transform.origin = $Camera3D.position
	#$Camera3D/RayCast3D.look_at($Camera3D.rotation)
	#$Camera3D/RayCast3D.force_raycast_update()
	#return $Camera3D/RayCast3D.get_collider()


func _on_enemy_reload() -> void:
	hasBullet = true
	emit_signal("hasAmmo")
