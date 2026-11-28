extends CharacterBody2D

@export var velocidade: float = 50.0
@export var corrida: float = 90
@export var dano_machado := 10
@export var intervalo_ataque := 0.5
@onready var sprite = $AnimatedSprite2D
var tempo_ataque := 0.0
var ultima_direcao := "baixo"
var atacando := false

func _ready() -> void:
	sprite.animation_finished.connect(_on_animacao_terminou)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("atacar") and GameState.tem_machado and not atacando:
		atacando = true
		sprite.play("ataque_" + ultima_direcao)
		print("ataque: ", $area_ataque.get_overlapping_bodies())  # TEMPORÁRIO
		for corpo in $area_ataque.get_overlapping_bodies():
			if corpo.is_in_group("inimigo"):
				corpo.receber_dano(dano_machado)

	if atacando:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var direcao := Input.get_vector("esquerda", "direita", "pra cima", "pra baixo")
	if Input.is_action_pressed("correr"):
		velocity = corrida * direcao
	else:
		velocity = velocidade * direcao
	move_and_slide()

	if direcao == Vector2.ZERO:
		sprite.play("parado_" + ultima_direcao) #toca a animacao de idle na direcaop que o player estiber
		return
	
	#na diafonal, vale o eixo que ele maiss se move
	if abs(direcao.x) > abs(direcao.y):
		if direcao.x > 0:
			ultima_direcao = "direita"
		else:
			ultima_direcao = "esquerda"
	else:
		if direcao.y > 0:
			ultima_direcao = "baixo"
		
		else:
			ultima_direcao = "cima"
	
	sprite.play("andando_"+ ultima_direcao)
	

func receber_dano(valor: int) -> void:
	GameState.alterar_sanidade(-valor) #perde sanidadeao recber dano
func _on_animacao_terminou() -> void:
	atacando = false
