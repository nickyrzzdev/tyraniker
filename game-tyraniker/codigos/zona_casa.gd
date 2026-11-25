extends Area2D

@onready var teto = get_node("../teto") #puxa o node do teto
<<<<<<< HEAD:game-tyraniker/codigos/zona_casa.gd
=======

>>>>>>> ad9f0a6f27c80d06403011bc050148defd2b42cd:game-tyraniker/scripts/zona_casa.gd

func _ready() -> void:
	body_entered.connect(_ao_entrar_corpo)
	body_exited.connect(_ao_sair_corpo)

func _ao_entrar_corpo(corpo) -> void:
	if not corpo.is_in_group("jogador"):
		return
	teto.visible = false

func _ao_sair_corpo(corpo) -> void:
	if not corpo.is_in_group("jogador"):
		return
	teto.visible = true
