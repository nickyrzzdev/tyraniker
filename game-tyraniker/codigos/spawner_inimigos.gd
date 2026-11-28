extends Node2D

@export var cena_inimigo: PackedScene
@export var pontos: Node2D
@export var qtd_inimigos := 8
@export var intervalo := 5.0

@onready var timer: Timer = $timer_spawn

var criados := 0


func _ready() -> void:
	timer.wait_time = intervalo
	timer.timeout.connect(_ao_tempo_acabar)
	GameState.noite_comecou.connect(_ao_anoitecer) #comeca apenas qnd anoitece
	
func _ao_anoitecer() -> void:
	timer.start()


func _ao_tempo_acabar() -> void:
	var ponto = pontos.get_children().pick_random()
	var inimigo = cena_inimigo.instantiate()
	add_child(inimigo)
	inimigo.global_position = ponto.global_position
	criados += 1
	if criados >= qtd_inimigos: #impede que nascam mais inimigps doq o codigo deixa
		timer.stop()
