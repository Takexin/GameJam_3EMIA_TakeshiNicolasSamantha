extends Node2D
@onready var player_camera : Camera2D = $player/Camera2D2
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect

var can_transition : bool = false
var shader_radius = 0:
	set(value):
		shader_radius = value
		color_rect.material.set_shader_parameter("radius", shader_radius)
signal finished
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_transition:
		shader_radius = lerpf(shader_radius, 0.7, 0.02)
		player_camera.zoom.x = lerpf(player_camera.zoom.x, 5, 0.02)
		player_camera.zoom.y = lerpf(player_camera.zoom.y, 5, 0.02)

func _on_final_platform_body_entered(body: Node2D) -> void:
	if body.is_in_group(&"player"):
		#var tween : Tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		#tween.tween_property(player_camera, "zoom", Vector2(5,5), 2)
		can_transition = true
		#color_rect.material.set_shader_parameter("radius", 1)



func _on_door_finished() -> void:
	finished.emit()
