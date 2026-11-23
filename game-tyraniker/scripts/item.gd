extends Area2D
class_name Item
#items colecionaveis do jogo
enum Tipo { madeira, sal, machado }

@export var tipo: Tipo = Tipo.madeira
#coloca os tres itens em uma array
@export var texturas: Array[Texture2D] = []

func _ready() -> void:
	body_entered.connect(_ao_entrar_corpo)
	if tipo < texturas.size():
		$Sprite2D.texture = texturas[tipo]
	

# se o jogador encostar no item ele desaparece e imprime qual item o jogador pegou
func _ao_entrar_corpo(corpo: Node2D) -> void:
	if not corpo.is_in_group("jogador"):
		return
	else:
		print(Tipo.keys()[tipo])
		queue_free()
