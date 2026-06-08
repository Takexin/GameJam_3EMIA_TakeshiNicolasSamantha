extends CharacterBody2D


@export var SPEED := 300.0
@export var JUMP_VELOCITY := -400.0
@export var ACCEL : float = 20.0

@export var RUN_MULTIPLIER : float = 10.0
var multiplier : float = 0.0

var can_jump : bool = false
func handle_jump() -> void:
	if not is_on_floor():
		if can_jump:
			await get_tree().create_timer(0.2).timeout
			can_jump = false
	else:
		can_jump = true
func die() -> void:
	get_tree().call_deferred(&"reload_current_scene")

func _physics_process(delta: float) -> void:
	handle_jump()
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and can_jump:
		can_jump = false
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("run"):
		multiplier = RUN_MULTIPLIER
	else:
		multiplier = 1.0
	
	if Input.is_action_just_pressed("debug"):
		get_tree().reload_current_scene()
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED * multiplier, ACCEL)
	else:
		velocity.x = move_toward(velocity.x, 0, ACCEL)

	move_and_slide()
