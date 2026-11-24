extends Node2D

signal casa_invadida

var total := 0
var caidas := 0

func _ready() -> void:
	total = get_child_count() #conta qunatas barricadas tem
	for barricada in get_children(): # for igual em python com a quantidade de barricadas dentro do nó pai
		barricada.destruida.connect(_ao_destruir_barricada) #conecta com funcao que emite que a casa foi invadids

func _ao_destruir_barricada() -> void:
	caidas += 1
	if caidas == total:
		casa_invadida.emit() #emite que a casa foi invadida
