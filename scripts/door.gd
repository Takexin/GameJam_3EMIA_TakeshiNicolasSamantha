extends Node2D

@export var animation_player: AnimationPlayer
var player_inside : bool = false
signal finished

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
