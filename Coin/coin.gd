class_name Coin
extends Area2D

signal collected

func _on_body_entered(body: Node2D) -> void:
	# Si le joueur entre dans la hitbox de la pièce
	if body is Player:
		collected.emit() # Indique qu'elle est collecté
		queue_free()     # Supprime la pièce de la scène
