extends Area2D

@onready var teto = get_node("../teto") #puxa o node do teto

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
