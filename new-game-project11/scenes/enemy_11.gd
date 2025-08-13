extends RigidBody2D

@onready var game_manager: Node = $"../GameManager"

func _ready() -> void:
	game_manager = get_node_or_null("/root/GameManager")
	if not game_manager:
		push_error("GameManager not found. Make sure it's Autoloaded in Project Settings.")

func _on_area_2d_body_entered(body: Node) -> void:
	if body.name == "CharacterBody2D":  # Check if it's the player
		
		# Compare positions: if player's feet are clearly above enemy's top
		if body.global_position.y + 5 < global_position.y:
			# Player stomped on the enemy
			print("Destroy enemy (stomped)!")
			queue_free()  # Remove enemy
			if body.has_method("jump"):
				body.jump()  # Bounce player
		else:
			# Player hit from side/below → decrease health
			print("Player hurt! Decrease health")
			if game_manager:
				game_manager.decrease_heart(1)
