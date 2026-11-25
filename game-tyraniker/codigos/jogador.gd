extends CharacterBody2D

@export var velocidade: float = 50.0
@export var corrida: float = 90

func _physics_process(_delta: float) -> void:
	var direcao := Input.get_vector("esquerda", "direita", "pra cima", "pra baixo")
	velocity = velocidade * direcao
	
	if Input.is_action_pressed("correr"):
		velocity = corrida * direcao
	
	move_and_slide()
