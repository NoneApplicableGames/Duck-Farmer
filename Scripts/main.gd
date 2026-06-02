##Class to handle game states and transitions, destroying and instantiating scenes as and when is needed.

class_name main
extends Node2D

signal change_game_scene(new_scene : PackedScene)

@export_category("Menus")

@export_category("Levels")

@export_category("Actors")
