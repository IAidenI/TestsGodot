extends Node2D

var total: int = 0
var score: int = 0

@onready var score_label: Label = $HUD/ScoreLabel

func _ready() -> void:
	$Player.position = get_viewport_rect().size / 2
	for child in get_children():
		if child is Coin:
			child.collected.connect(_on_coin_collected)
			total += 1
	update_label()

func _on_coin_collected() -> void:
	score += 1
	update_label()
	if score == total:
		score_label.text = "Toutes les pieces sont ramassées !"

func update_label() -> void:
	score_label.text = "Score : %d / %d" % [score, total]
