extends Node2D
@onready var player_camera : Camera2D = $player/Camera2D2
@onready var color_rect: ColorRect = $CanvasLayer/vignette
@onready var player: CharacterBody2D = $player

var can_transition : bool = false
var shader_radius = 0:
	set(value):
		shader_radius = value
		color_rect.material.set_shader_parameter("radius", shader_radius)
signal finished
signal reset

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_transition:
		shader_radius = lerpf(shader_radius, 0.7, 0.02)
		player_camera.zoom.x = lerpf(player_camera.zoom.x, 5, 0.02)
		player_camera.zoom.y = lerpf(player_camera.zoom.y, 5, 0.02)

func _on_final_platform_body_entered(body: Node2D) -> void:
	if body.is_in_group(&"player"):
		can_transition = true
		var player_audio : AudioStreamPlayer = player.audio
		player_audio.bus = "background"
		player.SPEED = 50



func _on_door_finished() -> void:
	finished.emit()


func _on_item_finished() -> void:
	player.on_item_pickup()


func _on_player_player_died() -> void:
	reset.emit()
