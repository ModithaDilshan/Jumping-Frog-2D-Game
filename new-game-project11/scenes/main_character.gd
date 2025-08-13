extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_JUMPS = 2

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var was_on_floor = false
var default = "default"
var jumps_performed = 0

func jump():
	velocity.y = JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			jumps_performed = 1
		elif jumps_performed < MAX_JUMPS:
			velocity.y = JUMP_VELOCITY
			jumps_performed += 1

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)

	move_and_slide()

	sprite_2d.flip_h = velocity.x < 0

	if not is_on_floor():
		sprite_2d.play("jumping")
	elif abs(velocity.x) > 1:
		sprite_2d.play("running")
	else:
		sprite_2d.play(default)

	if is_on_floor() and not was_on_floor:
		jumps_performed = 0
		sprite_2d.play(default)

	was_on_floor = is_on_floor()
