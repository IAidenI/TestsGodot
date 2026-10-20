class_name Player
extends CharacterBody2D

var speed: float = 400.0

var h_movement: int = 0
var v_movement: int = 0


func _physics_process(_delta: float) -> void:
	# Déplacement du joueur
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
