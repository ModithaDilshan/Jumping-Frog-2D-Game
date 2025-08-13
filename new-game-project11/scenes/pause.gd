extends Node

@onready var pause_panel: Panel = %"pause Panel"

func _process(delta: float) -> void:
	var esc_pressed = Input.is_action_just_pressed("pause")
	if esc_pressed == true:
		get_tree().paused = true
		pause_panel.show()

func _on_resume_pressed() -> void:
	pause_panel.hide()
	get_tree().paused = false

func _on_mainmen_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
