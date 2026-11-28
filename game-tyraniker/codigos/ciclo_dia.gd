extends CanvasModulate

@export var duracao_dia := 15
@export var cor_noite := Color(0.2, 0.2, 0.3)
@onready var timer_dia: Timer = $timer_dia

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_dia.one_shot = true #o timer dispara so uma vez
	timer_dia.wait_time = duracao_dia
	timer_dia.timeout.connect(_ao_anoitecer)
	timer_dia.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameState.eh_noite:
		return
	var progresso = 1 - timer_dia.time_left / duracao_dia
	color = Color.WHITE.lerp(cor_noite, progresso) #lerp mistura duas cores e escurece a tela gradualmnete

func _ao_anoitecer() -> void:
	GameState.comecar_noite()
