class_name title_screen
extends Control

var main_game
var current_scene : main.GAME_STATES

signal change_game_state(new_scene : PackedScene)

func _on_start_game_button_pressed() -> void:
	pass # Replace with function body.

func _on_settings_button_pressed() -> void:
	_call_for_scene_change(main.GAME_STATES.SETTINGS_MENU)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _call_for_scene_change(new_scene : main.GAME_STATES):
	emit_signal("change_game_scene")

func _ready() -> void:
	main_game = get_tree().get_first_node_in_group("main")
	main.change_game_state.connect(_call_for_scene_change)
