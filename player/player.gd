class_name Player
extends CharacterBody2D

const SPEED: float = 300.0
const JUMP_VELOCITY: float = -400.0

const MAX_JUMP_HEIGHT: float = 270.0

var is_jumping: bool = false
var jump_start_y: float = 0.0


func _physics_process(delta: float) -> void:
	# Ajout de la gravité
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Initialise le saut
	if Input.is_action_just_pressed("jump") and is_on_floor():
		is_jumping = true
		jump_start_y = position.y

	# Tant que le bouton est enfoncé et que le max height n'est pas attent, monter
	if is_jumping:
		var height := jump_start_y - position.y
		if Input.is_action_pressed("jump") and height < MAX_JUMP_HEIGHT:
			velocity.y = JUMP_VELOCITY
		else:
			is_jumping = false
	# Mouvements
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
