extends CharacterBody2D

@export var velocidade := 60.0
@export var dano := 10
@export var distancia_ataque := 20.0
@export var intervalo_ataque := 1.0

var alvo: Node2D = null
var tempo_ataque := 0.0

func _physics_process(delta: float) -> void:
	if not is_instance_valid(alvo):
		alvo = escolher_alvo()
	if alvo == null:
		return

	var distancia = global_position.distance_to(alvo.global_position)
	if distancia > distancia_ataque:
		velocity = global_position.direction_to(alvo.global_position) * velocidade
		move_and_slide()
	else:
		tempo_ataque -= delta
		if tempo_ataque <= 0.0:
			alvo.receber_dano(dano)
			tempo_ataque = intervalo_ataque


func escolher_alvo() -> Node2D:
	var mais_proxima: Node2D = null
	var menor_distancia := INF
	for barricada in get_tree().get_nodes_in_group("barricadas"):
		var distancia = global_position.distance_to(barricada.global_position)
		if distancia < menor_distancia:
			menor_distancia = distancia
			mais_proxima = barricada
	return mais_proxima
