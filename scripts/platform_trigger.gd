extends AnimatableBody2D
@export var animation_player : AnimationPlayer
var has_played = false
func _on_area_2d_body_entered(body: Node2D) -> void:
	if animation_player :
		if body.is_in_group("player") and !has_played:
			has_played = true
			animation_player.play("move")
