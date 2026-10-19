class_name Player
extends CharacterBody2D

@export var speed: float = 400.0


func _physics_process(_delta: float) -> void:
	# Physique du déplacement
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
