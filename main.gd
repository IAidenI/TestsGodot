extends Node2D

var total: int = 0
var score: int = 0

@onready var score_label: Label = $HUD/ScoreLabel

func _ready() -> void:
	# Affiche les commandes
	$HUD/ControlsLabel.text = "Déplacement :\n[indent]Haut : %s\nBas : %s\nGauche : %s\nDroite : %s[/indent]\nChanger de skin : %s" % [
		get_action_keys("move_up"),
		get_action_keys("move_down"),
		get_action_keys("move_left"),
		get_action_keys("move_right"),
	]

	# Centre le joueur à l'écran
	$Player.position = get_viewport_rect().size / 2
	
	# Parcourt tous les enfants directs de Main pour trouver les pièces
	for child in get_children():
		if child is Coin:
			# Abonne Main au signal "collected" de la pièce
			child.collected.connect(_on_coin_collected)
			total += 1
	# Affiche le score initial
	update_score()

func _on_coin_collected() -> void:
	score += 1
	update_score()
	
	if score == total:
		score_label.text = "Toutes les pieces sont ramassées !"

func update_score() -> void:
	score_label.text = "Score : %d / %d" % [score, total]

# Pour récupèrer les variables globals pour les commandes
func get_action_keys(action: String) -> String:
	var keys := PackedStringArray()
	for event in InputMap.action_get_events(action):
		if event is InputEventKey:
			var keycode: Key = event.keycode
			if keycode == KEY_NONE:
				keycode = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode)
			keys.append(OS.get_keycode_string(keycode))
	return "[color=yellow]%s[/color]" % " / ".join(keys)
