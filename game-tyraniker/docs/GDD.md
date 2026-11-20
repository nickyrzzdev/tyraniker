# [Tyraniker] — Mini-GDD

## 1. Visão geral
- **Engine:** Godot 4 (2D)
- **Gênero:** top-down de sobrevivência
- **Inspiração narrativa:** *Eu Sou a Lenda* (Richard Matheson)
- **Inspiração visual:** *Hylics e Hylics 2* (surreal, massinha/claymation, cores vibrantes)
- **Equipe:** Nicole Kyrstien Pontes de Souza
- **Prazo de entrega:** 07/12/2026

## 2. Conceito (pitch em 2 frases)
O mundo foi tomado por criaturas interdimensionais, você é o único humano que existe no planeta, seu objetivo é sobreviver por 3 dias até outra espécie intergalática te resgatar (ou não...) de dia, explore o bairro atrás de suprimentos; de noite, defenda sua casa e a própria sanidade.

## 3. Loop de jogo

### Dia (exploração)
- Explorar o bairro e coletar **madeira**, **sal grosso** e **machado**.
- Um timer representa o pôr do sol; é preciso voltar para casa antes de escurecer.
- Ficar longe da casa quando a noite cai reduz a sanidade.

### Noite (defesa)
- Criaturas cercam a casa e atacam as **3 barricadas** (janelas/portas).
- O jogador repara barricadas (gasta madeira), usa sal grosso para repelir e machado para matar.
- A **sanidade** cai com os chamados das criaturas e se recupera perto do rádio/música.

## 4. Recursos e mecânicas
| Elemento | Função |
|---|---|
| Madeira | Repara barricadas |
| Sal grosso | Repele criaturas por um tempo |
| Machado bestial | Mata criaturas que entram |
| Sanidade | Se chegar a zero, derrota; distorce o visual quando baixa |
| Barricada | Tem HP; se cair, a criatura entra |

## 5. Condições de vitória e derrota
- **Vitória:** sobreviver a 3 noites.
- **Derrota:** sanidade em zero ou jogador alcançado pelas criaturas.

## 6. Direção de arte e áudio
- Estética Hylics 2: formas distorcidas, cores contrastantes, animação quadro a quadro em baixo FPS.
- Shaders: *wobble* (ondulação) e posterização; intensidade ligada à sanidade.
- Iluminação dia/noite com `CanvasModulate` e `PointLight2D`.
- Assets desenhados por mim ou obtidos exclusivamente no itch.io (créditos no site).

## 7. Escopo (MVP)
**Dentro:** 1 mapa, 1 casa, 3 noites, 3 recursos, 1 tipo de inimigo, HUD simples.
**Fora:** inventário em grade, crafting, save/load, vários mapas, pathfinding avançado.

## 8. Cronograma
Ver o GitHub Projects (Roadmap) do repositório.
