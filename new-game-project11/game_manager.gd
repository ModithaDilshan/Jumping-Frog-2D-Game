extends Node

@onready var points_label: Label = $"../ui/Panel/pointsLabel"
@export var lives: Array[Node]  # Assign heart UI nodes (TextureRect/Control) in the Inspector

var points: int = 0
var hearts: int = 3  # Current hearts shown

func _ready() -> void:
	update_ui()
	update_hearts_ui()

func add_point(value: int = 1) -> void:
	points += value
	update_ui()
	print("Points collected:", points)

func add_heart(value: int = 1) -> void:
	hearts += value
	clamp_hearts_to_lives()
	update_hearts_ui()
	print("Hearts:", hearts)

func decrease_heart(value: int = 1) -> void:
	hearts -= value
	if hearts < 0:
		hearts = 0
	update_hearts_ui()
	print("Hearts:", hearts)
	if hearts <= 0:
		print("Game Over!")
		get_tree().reload_current_scene()

func update_ui() -> void:
	if points_label:
		points_label.text = "Points: " + str(points)

func update_hearts_ui() -> void:
	# Ensure the UI matches the hearts count
	if lives.is_empty():
		push_warning("Lives array is empty. Assign heart UI nodes in the Inspector.")
		return

	# Optional: clamp hearts to available icons
	clamp_hearts_to_lives()

	# Show first 'hearts' icons, hide the rest
	for i in range(lives.size()):
		var node := lives[i]
		if node == null:
			continue
		if i < hearts:
			if node.has_method("show"):
				node.show()
			elif "visible" in node:
				node.visible = true
		else:
			if node.has_method("hide"):
				node.hide()
			elif "visible" in node:
				node.visible = false

func clamp_hearts_to_lives() -> void:
	# Prevent hearts exceeding number of icons or going negative
	if lives.size() > 0 and hearts > lives.size():
		hearts = lives.size()
	if hearts < 0:
		hearts = 0
