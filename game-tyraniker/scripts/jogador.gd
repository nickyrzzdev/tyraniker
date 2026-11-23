extends CharacterBody2D

@export var velocidade: float = 50.0

func _physics_process(_delta: float) -> void:
	var direcao := Input.get_vector("esquerda", "direita", "pra cima", "pra baixo")
	velocity = velocidade * direcao
	move_and_slide()
