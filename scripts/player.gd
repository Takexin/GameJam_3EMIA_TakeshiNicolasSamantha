extends CharacterBody2D


@export var SPEED := 300.0
@export var JUMP_VELOCITY := -400.0
@export var ACCEL : float = 20.0
@export var audio: AudioStreamPlayer
@export var sprite: AnimatedSprite2D

@export var RUN_MULTIPLIER : float = 10.0
var multiplier : float = 1.0

var can_jump : bool = false

var is_walking : bool = false
var walking_pos : Array = [3,4,7,8]

var direction : float = 0.0

func handle_animations() -> void:
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
	
	if is_on_floor():
		if direction != 0:
			if multiplier != 1:
				sprite.play("run")
			else:
				sprite.play("walk")
		else:
			sprite.play("idle")
	elif !is_on_floor():
		if velocity.y < 0:
			sprite.play("jump_up")
		else:
			sprite.play("jump_down")

func handle_jump_animation() -> void:
	sprite.play("jump_prepare")
	await sprite.animation_finished
	
func handle_audio() -> void:
	if direction != 0 and is_on_floor():
		if !is_walking:
			is_walking = true
			audio.play(walking_pos[randi_range(0,walking_pos.size()-1)])
		if multiplier != 1:
			audio.pitch_scale = 2
		else:
			audio.pitch_scale = 1

	else:
		is_walking = false
		audio.stop()
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

		sprite.play("jump_prepare")
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("run"):
		multiplier = RUN_MULTIPLIER
	else:
		multiplier = 1.0
	
	if Input.is_action_just_pressed("debug"):
		get_tree().reload_current_scene()
	direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED * multiplier, ACCEL)
	else:
		velocity.x = move_toward(velocity.x, 0, ACCEL)
	handle_audio()
	handle_animations()
	move_and_slide()
