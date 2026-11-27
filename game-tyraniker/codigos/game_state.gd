extends Node

#sinais pra cada item e a sanidadw (e do timer do dia)
signal madeira_mudou(valor: int)
signal sal_mudou(valor: int)
signal machado_obtido
signal sanidade_mudou(valor: int)
signal noite_comecou

#a sanidade do prota vai de 0 a 100
const SANIDADE_MAX := 100

#inicializacao dos items e da sanidade que comeca em 100 (e do signal da noite)
var madeira := 0
var sal := 0
var tem_machado := false
var sanidade := SANIDADE_MAX
var eh_noite := false

func comecar_noite() -> void:
	eh_noite = true
	noite_comecou.emit() #emite o sinal pra noite cmecar


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
	
func gastar_madeira(quantidade: int) -> bool: #usa pra consertar a barricada
	if madeira < quantidade:
		return false
	madeira -= quantidade
	madeira_mudou.emit(madeira)
	return true

func alterar_sanidade(valor: int) -> void:
	# clampi impede que passe de 100 ou fique abaixo dw 0
	sanidade = clampi(sanidade + valor, 0, SANIDADE_MAX)
	sanidade_mudou.emit(sanidade)
	

func gastar_sal(quantidade: int) -> bool:
	if sal < quantidade:
		return false
	sal -= quantidade
	sal_mudou.emit(sal)
	return true
