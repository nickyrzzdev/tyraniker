extends StaticBody2D

signal destruida

@export var vida_maxima := 50
var vida := 0
@export var conserto:= 10
var jogador_perto := false
@export var duracao_sal := 15.0
var tempo_sal := 0.0

func _physics_process(delta: float) -> void:
	if tempo_sal > 0.0:
		tempo_sal -= delta
		if tempo_sal <= 0.0:
			$sprite_sal.visible = false

#qtd de vida que a barricada vai ter
func _ready() -> void:
	vida = vida_maxima
	$area_de_reparo.body_entered.connect(_ao_entrar_corpo)
	$area_de_reparo.body_exited.connect(_ao_sair_corpo)

func receber_dano(valor: int) -> void:
	
	vida -= valor
	
	if vida <= 0:
		destruida.emit()
		queue_free() #remove a barricada
		return
	atualizar_cor()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("consertar") and jogador_perto:
		consertar()
	if event.is_action_pressed("salgar") and jogador_perto:
		salgar()
		
func salgar() -> void:
	if tempo_sal > 0.0: #se ela ja ta salgada o sal n eh gasto dnv eh a mesma ideia da vida cheia ds barricada no consertar
		return
	if not GameState.gastar_sal(1): #primeiro confere se ja ta salgada depois gasta o sal assim o jogador n perde sal atoa
		return
	tempo_sal = duracao_sal
	$sprite_sal.visible = true #a barricada aparece com o sal por cima

func consertar() -> void:
	if vida >= vida_maxima: #se a barricada tiber cpm vida cheia nao deixa o jogador consertar
		return
	if not GameState.gastar_madeira(1):
		return
	vida = mini(vida + conserto, vida_maxima)
	atualizar_cor() #muda a cor pro original


func atualizar_cor() -> void:
#escurece enquanto vai perdendp vida (lerp que faz isso, e faz simultaneamente enquanto a barricada vai perdendo vida)
	$Sprite2D.modulate = Color.WHITE.lerp(Color.DARK_RED, 1.0 - float(vida) / vida_maxima)

func _ao_entrar_corpo(corpo: Node2D) -> void:
	if not corpo.is_in_group("jogador"): #condicao pra saber se o corpo q ta perto é o jogador
		return
	jogador_perto = true

func _ao_sair_corpo(corpo: Node2D) -> void:
	if not corpo.is_in_group("jogador"):
		return
	jogador_perto = false
