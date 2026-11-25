extends Node2D
@export var cena_item: PackedScene
@export var pontos_itens: Node2D 
@export var qtd_madeira := 33
@export var qtd_sal := 20
@export var qtd_machado := 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var lista = pontos_itens.get_children()
	# embaralha os itens
	lista.shuffle()
	
	var indice := 0
	
	for i in qtd_machado:
		if indice >= lista.size():
			return
		_criar_item(Item.Tipo.machado, lista[indice])
		indice += 1
	
	for i in qtd_madeira:
		if indice >= lista.size():
			return # acabaram os itens
		_criar_item(Item.Tipo.madeira, lista[indice])
		indice += 1
		
	for i in qtd_sal:
		if indice >= lista.size():
			return # acabaram os itens
		_criar_item(Item.Tipo.sal, lista[indice])
		indice += 1


func _criar_item(tipo: Item.Tipo, ponto: Node2D) -> void:
	var item = cena_item.instantiate() #faz copia dp item.tscn
	item.tipo = tipo #define qual item antes de entrar nacena
	item.global_position = ponto.global_position
	add_child(item) #aparece no mapa
