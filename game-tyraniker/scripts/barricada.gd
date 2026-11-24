extends StaticBody2D

signal destruida

@export var vida_maxima := 50
var vida := 0

#qtd de vida que a barricada vai ter
func _ready() -> void:
	vida = vida_maxima


func receber_dano(valor: int) -> void:
	
	vida -= valor
	
	if vida <= 0:
		destruida.emit()
		queue_free() #remove a barricada
		return
		
	#escurece enqunato vai perdendo vida (lerp que faz isso, e faz simultaneamente enquanto a barricada vai perdendo vida)
	$Sprite2D.modulate = Color.WHITE.lerp(Color.DARK_RED, 1.0 - float(vida) / vida_maxima)
