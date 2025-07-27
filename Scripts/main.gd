extends Node3D

signal resumeGame
@export var mouseSensitivity = 450 # Making this bigger makes the mouse movement less sensitive
var mouseLock = true
const adsFov = 15
const stdFov = 75

func _ready():
	$Player.rotation = Vector3(0,0,0)



func _physics_process(delta: float):
	if Input.is_action_just_pressed("aimDownSights"):
		Engine.time_scale = 0.1 # Bullet Time
		$Player.setCamFOV(adsFov) # Camera focuses in for ADS
		mouseSensitivity *= 4 # This allows for more precise movements when ADSing
		$Player.gunPosADS()
	if Input.is_action_just_released("aimDownSights"):
		Engine.time_scale = 1 # Normal Time
		$Player.setCamFOV(stdFov) # Camera focuses out for normal movement
		mouseSensitivity /= 4 # This changes us back to standard sensitivity when not ADSing
		$Player.gunPosStd()
	if Input.is_action_just_pressed("fireGun"):
		
		if $Player.hasBullet:
			$Player.hasBullet = false
			var target = $Player.fireShot()
			if target != null && target.hasMethod("destroy"):
				target.destroy()
	if Input.is_action_just_pressed("Crouch"):
		$Player.scale.y = .5
		$Player.SPEED /= 3
	if Input.is_action_just_released("Crouch"):
		$Player.scale.y = 1.0
		$Player.SPEED *= 3
	
	var mousePosition = get_viewport().get_mouse_position()
	
	if mouseLock:
		get_viewport().warp_mouse(get_viewport().size/2)
		$Player.rotate_y(-(mousePosition.x - (get_viewport().size.x / 2)) / mouseSensitivity)
		$Player.turnCamera((mousePosition.y - (get_viewport().size.y / 2)) / mouseSensitivity)
	if Input.is_action_just_pressed("Menu"):
		mouseLock = !mouseLock
		if !mouseLock:
			Engine.time_scale = 0.0
		else:
			mouseSensitivity = 450 * $pauseMenu.sensitivity
			Engine.time_scale = 1.0
		get_viewport().warp_mouse(get_viewport().size/2)
	var direction = Vector3.ZERO
	
	


func _on_pause_menu_continue_game() -> void:
	get_viewport().warp_mouse(get_viewport().size/2)
	mouseLock = true
	mouseSensitivity = 450 * $pauseMenu.sensitivity
	$pauseMenu.isShown = false
	Engine.time_scale = 1.0
	
