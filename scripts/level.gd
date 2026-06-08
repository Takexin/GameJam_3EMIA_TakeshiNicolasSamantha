extends Node2D
@onready var player_camera : Camera2D = $player/Camera2D2
signal finished
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_final_platform_body_entered(body: Node2D) -> void:
	if body.is_in_group(&"player"):
		var tween : Tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(player_camera, "zoom", Vector2(5,5), 2)
	


func _on_door_finished() -> void:
	finished.emit()
