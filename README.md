# Tyraniker

Jogo top-down de sobrevivência em 2D feito em **Godot 4**, inspirado em *Eu Sou a Lenda* (Richard Matheson) e na estética de *Hylics 2*.

O mundo foi tomado por criaturas interdimensionais e você é o único humano que restou. De dia, explore o bairro atrás de suprimentos; de noite, defenda sua casa e a própria sanidade até ser resgatado.

> **Status:** em desenvolvimento. Entrega prevista para 07/12/2026.

<!-- PREENCHER: depois da Fase 3, coloque aqui um print ou GIF do jogo -->
<!-- ![Captura de tela](docs/img/captura.png) -->

## Como jogar

- **Mover:** WASD ou setas <!-- CONFIRMAR: bate com o seu Input Map? -->
- **Objetivo:** sobreviver a 3 noites.
- **Dia:** colete madeira e sal grosso, procure o machado e volte para casa antes de escurecer.
- **Noite:** repare as barricadas, use sal grosso para repelir as criaturas e mantenha a sanidade acima de zero.

Os detalhes das mecânicas estão no [mini-GDD](game_tyraniker/docs/GDD.md).

## Como executar

1. Instale o [Godot 4](https://godotengine.org/download) (versão: <!-- PREENCHER: a que você usa, em Help → About -->).
2. Clone o repositório:
   ```bash
   git clone https://github.com/nickyrzzdev/tyraniker.git
   ```
3. No Godot, clique em **Import**, escolha o arquivo `project.godot` dentro de `game_tyraniker/` e abra o projeto.
4. Aperte **F5** para rodar.

<!-- PREENCHER na Fase 5: link da build web jogável -->

## Estrutura do projeto

```
game_tyraniker/
├── scenes/    cenas (.tscn)
├── scripts/   scripts GDScript
├── assets/    sprites, tilesets, sons e fontes
├── shaders/   shaders 2D (wobble e posterização)
└── docs/      GDD e referências
```

## Tecnologias

- Godot 4 (GDScript)
- GitHub Projects (cronograma com Roadmap) e GitHub Pages (site de divulgação)

## Gestão do projeto

O planejamento está no GitHub Projects, com as tarefas organizadas em issues e milestones por fase (Pré-produção, Protótipo, Arte e Shaders, Polimento e GitHub Pages). Os commits seguem o padrão `feat:`, `fix:`, `art:`, `docs:` e `chore:`, e cada tarefa é desenvolvida numa branch própria com Pull Request.

## Créditos

Todos os assets de terceiros vêm do [itch.io](https://itch.io). A lista completa, com autor e licença de cada um, está em [REFERENCIAS.md](game_tyraniker/docs/REFERENCIAS.md).

Inspiração visual: [Hylics 2](https://mason-lindroth.itch.io/hylics-2), de Mason Lindroth. Nenhum asset do jogo original foi reutilizado.

## Autora

Nicole Kyrstien Pontes de Souza
