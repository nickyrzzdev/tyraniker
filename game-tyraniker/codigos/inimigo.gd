extends CharacterBody2D

#script feito cm ajuda da documentacao e forum sobre ia basic ade inimigo

@export var velocidade := 30.0
@export var dano := 10
@export var distancia_ataque := 20.0
@export var intervalo_ataque := 1.0
@export var vida := 30
@export var distancia_visao := 150.0
var tempo_desvio := 0.0
var lado_desvio := 0.6

func _ready() -> void:
	var animacoes = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(animacoes[randi() % animacoes.size()]) #expressao pega em forum

func receber_dano(valor: int) -> void:
	vida -= valor
	if vida <= 0:
		queue_free() #a criatura morre
		return

var alvo: Node2D = null
var tempo_ataque := 0.0

func _physics_process(delta: float) -> void:
	alvo = escolher_alvo()
	if alvo == null:
		return

	#codigo do inimigo desviar de paredes feito cm auxilio de i.a
	var distancia = global_position.distance_to(alvo.global_position)
	if distancia > distancia_ataque:
		var direcao = global_position.direction_to(alvo.global_position)
		if tempo_desvio > 0.0:
			tempo_desvio -= delta
			direcao = direcao.rotated(lado_desvio * PI / 2)
		velocity = direcao * velocidade
		move_and_slide()

		if tempo_desvio <= 0.0 and get_slide_collision_count() > 0:
			var corpo = get_slide_collision(0).get_collider()
			if not corpo.is_in_group("barricadas") and get_real_velocity().length() < velocidade * 0.3:
				tempo_desvio = 0.6
				lado_desvio = [-1.0, 1.0].pick_random()
	else:
		tempo_ataque -= delta
		if tempo_ataque <= 0.0:
			alvo.receber_dano(dano)
			tempo_ataque = intervalo_ataque



func escolher_alvo() -> Node2D:
	var jogador = get_tree().get_first_node_in_group("jogador")
	if jogador != null and global_position.distance_to(jogador.global_position) < distancia_visao:
		return jogador

	var mais_proxima: Node2D = null
	var menor_distancia := INF
	for barricada in get_tree().get_nodes_in_group("barricadas"):
		if barricada.tempo_sal > 0.0:
			continue
		var distancia = global_position.distance_to(barricada.global_position)
		if distancia < menor_distancia:
			menor_distancia = distancia
			mais_proxima = barricada
	return mais_proxima
