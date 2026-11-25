extends CharacterBody2D

@export var velocidade: float = 50.0
@export var corrida: float = 90
@onready var sprite = $AnimatedSprite2D
var ultima_direcao := "baixo"

func _physics_process(_delta: float) -> void:
	var direcao := Input.get_vector("esquerda", "direita", "pra cima", "pra baixo")
	velocity = velocidade * direcao
	
	if Input.is_action_pressed("correr"):
		velocity = corrida * direcao
	
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
