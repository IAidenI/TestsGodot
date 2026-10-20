\# A FAIRE ABSOLUMENT UNE FOIS AU DÉBUT

```bash

pip install pre-commit "gdtoolkit==4.\*"

pre-commit install

```



\# Organisation du projet



Rangement \*\*par élément\*\* : chaque entitées a son dossier avec sa scène, son script et ses assets. On ne cherche pas à 3 endroits pour modifier un élément.



```

res://

├── addons/                     # Plugins tiers (jamais modifiés à la main)

│

├── autoloads/                  # Singletons globaux, le strict minimum

│   ├── game\_manager.gd         # État global : run en cours, planète actuelle

│   ├── save\_manager.gd         # Sauvegarde / chargement (user://)

│   ├── audio\_manager.gd        # Musique et sons globaux

│   └── events.gd               # Bus d'événements : signaux globaux (player\_died, planet\_cleared…)

│

├── components/                 # Briques réutilisables par plusieurs entités

│   ├── health/                 # health\_component.tscn / .gd

│   ├── hitbox/                 # Ce qui inflige des dégâts

│   ├── hurtbox/                # Ce qui reçoit des dégâts

│   └── state\_machine/          # state\_machine.gd + state.gd (classes de base)

│

├── characters/

│   ├── player/

│   │   ├── player.tscn

│   │   ├── player.gd

│   │   ├── states/             # idle.gd, run.gd, jump.gd, fall.gd, dead.gd

│   │   └── sprites/

│   ├── enemies/

│   │   ├── enemy.gd            # Classe de base des ennemis

│   │   └── slime/

│   │       ├── slime.tscn

│   │       ├── slime.gd

│   │       ├── states/

│   │       └── sprites/

│   └── bosses/

│       └── final\_boss/

│

├── items/

│   ├── pickups/                # Pièces, soins, munitions

│   ├── weapons/

│   └── projectiles/

│

├── world/

│   ├── generation/             # planet\_generator.gd, room\_placer.gd

│   ├── rooms/                  # Salles préfabriquées, rangées par biome

│   │   ├── common/

│   │   ├── ice/

│   │   └── lava/

│   ├── biomes/                 # Tilesets + réglages de chaque type de planète

│   │   ├── ice/

│   │   └── lava/

│   └── props/                  # Portes, coffres, terminaux et objets de lore

│

├── ui/

│   ├── hud/

│   ├── menus/                  # main\_menu/, pause\_menu/, settings\_menu/, game\_over/

│   ├── touch\_controls/         # Joystick virtuel, boutons

│   ├── widgets/                # Petits éléments d'UI réutilisables (bouton stylé, barre de vie…)

│   └── themes/                 # Thèmes d'UI (.tres)

│

├── data/                       # Données de jeu en Resources : on équilibre sans toucher au code

│   ├── survivors/              # survivor\_data.gd + un .tres par survivant

│   ├── enemies/                # Stats des ennemis

│   ├── items/                  # Stats des objets et armes

│   ├── biomes/                 # Paramètres de génération par biome

│   └── lore/                   # Les indices de lore (textes, conditions d'apparition)

│

├── utils/                      # Fonctions static et constantes utilisées partout

│   ├── constants.gd

│   └── math\_utils.gd

│

├── shared/                     # Assets utilisés par plusieurs éléments

│   ├── fonts/

│   ├── music/

│   ├── sfx/

│   ├── shaders/

│   └── vfx/                    # Particules, effets réutilisables

│

├── main.tscn                   # Point d'entrée : menus, chargement des planètes, transitions

├── main.gd

│

├── docs/                       # .gdignore : ignoré par Godot

├── art\_sources/                # .gdignore : fichiers .aseprite, .psd, .kra

├── tests/                      # Tests (GUT ou gdUnit4)

│

├── project.godot

├── export\_presets.cfg

├── icon.svg

├── README.md

└── (fichiers de config : .gitignore, .gitattributes, .editorconfig, .pre-commit-config.yaml)

```



\*\*Règles\*\*

\- Un fichier qui ne sert qu'à un élément va \*\*dans le dossier de cet élément\*\*.

\- Un fichier utilisé par plusieurs éléments va dans `shared/` ou `components/`.

\- Les builds (`.exe`, `.apk`) ne vont \*\*jamais\*\* dans le projet.



\---



\# Nommage



| Élément | Style | Exemple |

|---|---|---|

| Fichiers et dossiers | `snake\_case` | `player\_sheet.png`, `main\_menu.tscn` |

| `class\_name` | `PascalCase` | `Player`, `HealthComponent` |

| Nodes dans l'arbre | `PascalCase` | `AnimatedSprite2D`, `ScoreLabel` |

| Variables, fonctions | `snake\_case` | `max\_health`, `take\_damage()` |

| Variables / fonctions privées | `\_snake\_case` | `\_velocity\_cache`, `\_update\_ui()` |

| Constantes | `CONSTANT\_CASE` | `MAX\_SPEED`, `GRAVITY` |

| Enums | `PascalCase` / `CONSTANT\_CASE` | `enum State { IDLE, RUN, JUMP }` |

| Signaux | `snake\_case`, \*\*au passé\*\* | `died`, `health\_changed`, `item\_collected` |

| Fonctions connectées à un signal | `\_on\_<node>\_<signal>` | `\_on\_hurtbox\_area\_entered()` |

| Actions d'input | `snake\_case` | `move\_left`, `jump`, `attack` |

| Groupes | `snake\_case`, au pluriel | `enemies`, `pickups` |

| Booléens | Question en `is\_` / `has\_` / `can\_` | `is\_dead`, `has\_key`, `can\_jump` |



\*\*Tout en minuscules pour les fichiers\*\* : Windows ne fait pas la différence, mais Android, Linux et l'export oui. Une faute de casse = un crash chez le joueur.



\---



\# Gitt



\## Ce qui est versionné

✅ `project.godot`, `export\_presets.cfg`, tous les `.tscn`, `.tres`, `.gd`, `.uid`, `.import`, les assets.  

❌ `.godot/`, les builds (`\*.exe`, `\*.apk`, `\*.pck`), les fichiers perso de l'OS.



```gitignore

.godot/

builds/

\*.exe

\*.apk

\*.aab

\*.pck

.DS\_Store

Thumbs.db

```



Assets lourds (sprites, musiques) : envisager \*\*Git LFS\*\* si le repo grossit.



\## Branches

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



\## Commits

Format \*\*Conventional Commits\*\* :

```

feat: ajoute le double saut

fix: la pièce était comptée deux fois

refactor: découpe le joueur en composants

docs: met à jour le guide dev

chore: ajoute le .gitignore

```

Petits commits, un sujet par commit.



\## Travailler à plusieurs

\- Les `.tscn` se mergent mal : \*\*éviter que deux personnes modifient la même scène en même temps\*\*. Se prévenir avant.

\- C'est aussi pour ça qu'on découpe en petites scènes : moins de conflits.

\- Toujours `git pull` avant de commencer à bosser.



\## Versions

Tags en \*\*SemVer\*\* : `v0.1.0` (premier prototype jouable), `v0.2.0` (nouvelle fonctionnalité), `v0.2.1` (correctif).



