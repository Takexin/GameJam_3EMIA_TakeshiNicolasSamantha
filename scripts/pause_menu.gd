extends CanvasLayer
@onready var main: Node = $".."
# ao ser criado na tela, o menu é escondido
func _ready() -> void:
	hide()

func _input(event) -> void:
	if !main.level_instance: return
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			if main.level_instance:
				main.level_instance.canvas_layer.show()
			hide()
			get_tree().paused = false
		else:
			if main.level_instance:
				main.level_instance.canvas_layer.show()
			show()
			get_tree().paused = true
	
# função que executa quando o botão Continuar é clicado, removendo
# o estado de pause da cena para voltar o jogo e escondendo o menu
func _on_continuar_button_pressed() -> void:
	hide()
	get_tree().paused = false

# função que executa quando o botão Menu Inicial é clicado,
# removendo o pause do jogo e mudando para a tela do menu inicial
func _on_menu_principal_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
