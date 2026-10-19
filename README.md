# Organisation du projet

Rangement **par élément** : chaque entitées a son dossier avec sa scène, son script et ses assets. On ne cherche pas à 3 endroits pour modifier un élément.

```
res://
├── addons/                  # Plugins tiers (ne pas modifier)
├── autoloads/               # Singletons globaux (le moins possible)
│   ├── game_manager.gd      # État de la partie, run en cours
│   ├── save_manager.gd      # Sauvegarde / chargement
│   └── audio_manager.gd     # Musique et sons globaux
├── characters/
│   ├── player/
│   │   ├── player.tscn
│   │   ├── player.gd
│   │   └── player_sheet.png
│   └── enemies/
│       ├── enemy.gd         # Classe de base des ennemis
│       └── slime/
│           ├── slime.tscn
│           ├── slime.gd
│           └── slime_sheet.png
├── components/              # Briques réutilisables (vie, hitbox…)
│   ├── health_component/
│   ├── hitbox_component/
│   └── hurtbox_component/
├── items/                   # Objets, armes, pickups
├── levels/
│   ├── generation/          # Code de génération procédurale
│   ├── rooms/               # Salles préfabriquées
│   └── biomes/              # Tilesets et réglages par type de planète
├── ui/
│   ├── hud/
│   ├── menus/
│   └── touch_controls/
├── data/                    # Ressources de données (.tres) : stats, loot tables, dialogues
├── shared/                  # Assets utilisés partout
│   ├── fonts/
│   ├── sfx/
│   ├── music/
│   └── shaders/
├── main.tscn                # Point d'entrée : charge les menus et les niveaux
└── main.gd
```

**Règles**
- Un fichier qui ne sert qu'à un élément va **dans le dossier de cet élément**.
- Un fichier utilisé par plusieurs éléments va dans `shared/` ou `components/`.
- Les builds (`.exe`, `.apk`) ne vont **jamais** dans le projet.

---

# Nommage

| Élément | Style | Exemple |
|---|---|---|
| Fichiers et dossiers | `snake_case` | `player_sheet.png`, `main_menu.tscn` |
| `class_name` | `PascalCase` | `Player`, `HealthComponent` |
| Nodes dans l'arbre | `PascalCase` | `AnimatedSprite2D`, `ScoreLabel` |
| Variables, fonctions | `snake_case` | `max_health`, `take_damage()` |
| Variables / fonctions privées | `_snake_case` | `_velocity_cache`, `_update_ui()` |
| Constantes | `CONSTANT_CASE` | `MAX_SPEED`, `GRAVITY` |
| Enums | `PascalCase` / `CONSTANT_CASE` | `enum State { IDLE, RUN, JUMP }` |
| Signaux | `snake_case`, **au passé** | `died`, `health_changed`, `item_collected` |
| Fonctions connectées à un signal | `_on_<node>_<signal>` | `_on_hurtbox_area_entered()` |
| Actions d'input | `snake_case` | `move_left`, `jump`, `attack` |
| Groupes | `snake_case`, au pluriel | `enemies`, `pickups` |
| Booléens | Question en `is_` / `has_` / `can_` | `is_dead`, `has_key`, `can_jump` |

**Tout en minuscules pour les fichiers** : Windows ne fait pas la différence, mais Android, Linux et l'export oui. Une faute de casse = un crash chez le joueur.

---

# Git

## Ce qui est versionné
✅ `project.godot`, `export_presets.cfg`, tous les `.tscn`, `.tres`, `.gd`, `.uid`, `.import`, les assets.  
❌ `.godot/`, les builds (`*.exe`, `*.apk`, `*.pck`), les fichiers perso de l'OS.

```gitignore
.godot/
builds/
*.exe
*.apk
*.aab
*.pck
.DS_Store
Thumbs.db
```

Assets lourds (sprites, musiques) : envisager **Git LFS** si le repo grossit.

## Branches
| Branche | Rôle |
|---|---|
| `main` | Version stable, qui marche toujours |
| `dev` | Intégration en cours |
| `feature/<nom>` | Nouvelle fonctionnalité : `feature/player-jump`, `feature/procedural-gen` |
| `fix/<nom>` | Correction de bug : `fix/coin-double-count` |
| `refactor/<nom>` | Réorganisation sans changer le comportement |
| `docs/<nom>` | Documentation |
| `chore/<nom>` | Maintenance, config, outils |

Noms en `kebab-case`, courts et explicites. On part de `dev`, on merge dans `dev`, et `dev` part dans `main` quand c'est stable.

## Commits
Format **Conventional Commits** :
```
feat: ajoute le double saut
fix: la pièce était comptée deux fois
refactor: découpe le joueur en composants
docs: met à jour le guide dev
chore: ajoute le .gitignore
```
Petits commits, un sujet par commit.

## Travailler à plusieurs
- Les `.tscn` se mergent mal : **éviter que deux personnes modifient la même scène en même temps**. Se prévenir avant.
- C'est aussi pour ça qu'on découpe en petites scènes : moins de conflits.
- Toujours `git pull` avant de commencer à bosser.

## Versions
Tags en **SemVer** : `v0.1.0` (premier prototype jouable), `v0.2.0` (nouvelle fonctionnalité), `v0.2.1` (correctif).
