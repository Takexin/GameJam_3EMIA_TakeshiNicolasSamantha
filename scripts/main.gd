extends Node

@export var level: PackedScene
@export var control: Control
@export var end_cutscene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var level_instance = level.instantiate()
	level_instance.finished.connect(on_finished)
	control.visible = false
	add_child(level_instance)

func on_finished() -> void:
	get_node("level").queue_free()
	var cutscene_instance = end_cutscene.instantiate()
	add_child(cutscene_instance)
	
	
