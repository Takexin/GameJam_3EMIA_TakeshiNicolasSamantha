extends Node

@onready var gameover: Control = $CanvasLayer/Gameover
@export var level: PackedScene
@export var control: Control
@export var end_cutscene: PackedScene
var level_instance : Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_level() -> void:
	level_instance = level.instantiate()
	level_instance.finished.connect(on_finished)
	level_instance.reset.connect(on_level_player_died)
	control.visible = false
	add_child(level_instance)

func _on_button_pressed() -> void:
	load_level()
func on_finished() -> void:
	level_instance.queue_free()
	var cutscene_instance = end_cutscene.instantiate()
	add_child(cutscene_instance)
	

func on_level_player_died() -> void:
	gameover.show()

func retry() -> void:
	gameover.hide()
	level_instance.queue_free()
	load_level()

func exit() -> void:
	get_tree().quit()
