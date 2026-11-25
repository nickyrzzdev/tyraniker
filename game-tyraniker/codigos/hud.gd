extends CanvasLayer

@onready var label_madeira: Label = $VBoxContainer/LabelMadeira
@onready var label_sal: Label = $VBoxContainer/LabelSal
@onready var label_machado: Label = $VBoxContainer/LabelMachado
@onready var label_sanidade: Label = $VBoxContainer/LabelSanidade


func _ready() -> void:
	GameState.madeira_mudou.connect(_atualizar_madeira)
	GameState.sal_mudou.connect(_atualizar_sal)
	GameState.machado_obtido.connect(_atualizar_machado)
	GameState.sanidade_mudou.connect(_atualizar_sanidade)

	#textos iniciais antes de pegar o primeiro item
	_atualizar_madeira(GameState.madeira)
	_atualizar_sal(GameState.sal)
	label_machado.text = "Machado: não"
	_atualizar_sanidade(GameState.sanidade)

#atualiza o vaplor no hud
func _atualizar_madeira(valor: int) -> void:
	label_madeira.text = "Madeira: " + str(valor)


func _atualizar_sal(valor: int) -> void:
	label_sal.text = "Sal: " + str(valor)

#aqui usei true/false pra saber se o player ta com machado ou n
func _atualizar_machado() -> void:
	label_machado.text = "Machado: sim"


func _atualizar_sanidade(valor: int) -> void:
	label_sanidade.text = "Sanidade: " + str(valor)
