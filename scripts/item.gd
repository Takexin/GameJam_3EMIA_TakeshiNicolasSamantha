extends Node2D
@export var text: RichTextLabel
@export var animation_player: AnimationPlayer
var player_inside : bool = false
signal finished
@onready var sprite: Sprite2D = $door
@onready var pickup_sprite: Sprite2D = $Sprite2D
@onready var area: Area2D = $Area2D
@onready var pickup_sound: AudioStreamPlayer = $pickupSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group(&"player"):
		animation_player.speed_scale = 1
		animation_player.play("interact")
		player_inside = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group(&"player"):
		animation_player.play_backwards("interact")
		player_inside = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_inside:
		finished.emit()
		on_finished()
func on_finished() -> void:
	pickup_sound.play()
	sprite.visible = false
	pickup_sprite.visible = false
	area.monitoring = false
	var tween = get_tree().create_tween()
	tween.tween_property(text, "visible_ratio", 1, 1)
	await get_tree().create_timer(4).timeout
	text.visible = false
	
