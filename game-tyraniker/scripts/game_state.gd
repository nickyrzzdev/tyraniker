extends Node

#sinais pra cada item e a sanidadw
signal madeira_mudou(valor: int)
signal sal_mudou(valor: int)
signal machado_obtido
signal sanidade_mudou(valor: int)

#a sanidade do prota vai de 0 a 100
const SANIDADE_MAX := 100

#inicializacao dos items e da sanidade que comeca em 100
var madeira := 0
var sal := 0
var tem_machado := false
var sanidade := SANIDADE_MAX


func adicionar_item(tipo: Item.Tipo) -> void:
	#match funciona da mesma forma que o match case de python
	match tipo:
		Item.Tipo.madeira:
			madeira += 1
			madeira_mudou.emit(madeira)
		Item.Tipo.sal:
			sal += 1
			sal_mudou.emit(sal)
		Item.Tipo.machado:
			tem_machado = true
			machado_obtido.emit()


func alterar_sanidade(valor: int) -> void:
	# clampi impede que passe de 100 ou fique abaixo dw 0
	sanidade = clampi(sanidade + valor, 0, SANIDADE_MAX)
	sanidade_mudou.emit(sanidade)
