class_name Player
extends CharacterBody2D

@export var speed: float = 400.0

const SKIN_A := preload("res://assets/sprits/player1.png")
const SKIN_B := preload("res://assets/sprits/player2.png")
const SKIN_C := preload("res://assets/sprits/player3.png")
const SKIN_D := preload("res://assets/sprits/player4.png")

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("change_skin"):
		match $Sprite2D.texture:
			SKIN_A:
				$Sprite2D.texture = SKIN_B
			SKIN_B:
				$Sprite2D.texture = SKIN_C
			SKIN_C:
				$Sprite2D.texture = SKIN_D
			_:
				$Sprite2D.texture = SKIN_A
