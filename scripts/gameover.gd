extends Control
signal retry
signal exit
func _on_retry_pressed() -> void:
	retry.emit()

func _on_exit_pressed() -> void:
	get_tree().reload_current_scene()
