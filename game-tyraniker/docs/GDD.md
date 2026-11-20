# Tyraniker — Mini-GDD

## 1. Visão geral
- **Engine:** Godot 4 (2D)
- **Gênero:** top-down de sobrevivência
- **Inspiração narrativa:** *Eu Sou a Lenda* (Richard Matheson)
- **Inspiração visual:** *Hylics e Hylics 2* (surreal, massinha/claymation, cores vibrantes)
- **Equipe:** Nicole Kyrstien Pontes de Souza
- **Prazo de entrega:** 07/12/2026

## 2. Conceito (pitch em 2 frases)
O mundo foi tomado por criaturas interdimensionais e você é o único humano que restou. Seu objetivo é sobreviver por 3 dias até outra espécie intergaláctica te resgatar (ou não...): de dia, explore o bairro atrás de suprimentos; de noite, defenda sua casa e a própria sanidade.

## 3. Loop de jogo

### Dia (exploração)
- Explorar o bairro e coletar **madeira** e **sal grosso**.
- Procurar o **machado**, um item único e raro, escondido em algum lugar do mapa.
- Um timer representa o pôr do sol; é preciso voltar para casa antes de escurecer.
- Ficar longe da casa quando a noite cai reduz a sanidade.

### Noite (defesa)
- Criaturas cercam a casa e atacam as **3 barricadas** (janelas/portas).
- O jogador repara barricadas (gasta madeira) e usa sal grosso para repelir as criaturas.
- Quem já encontrou o machado também pode matar as criaturas que entram. Sem ele, a defesa depende só de barricada e sal.
- A **sanidade** cai com os chamados das criaturas e se recupera perto do rádio/música.

## 4. Recursos, itens e mecânicas
| Elemento | Tipo | Função |
|---|---|---|
| Madeira | Recurso (contador, se gasta) | Repara barricadas |
| Sal grosso | Recurso (contador, se gasta) | Repele criaturas por um tempo |
| Machado | Item único (não se gasta) | Mata criaturas que entram; difícil de achar no mapa |
| Sanidade | Medidor | Se chegar a zero, derrota; distorce o visual quando baixa |
| Barricada | Estrutura | Tem HP; se cair, a criatura entra |

## 5. Condições de vitória e derrota
- **Vitória:** sobreviver a 3 noites.
- **Derrota:** sanidade em zero ou jogador alcançado pelas criaturas.

## 6. Direção de arte e áudio
- Estética Hylics 2: formas distorcidas, cores contrastantes, animação quadro a quadro em baixo FPS.
- Shaders: *wobble* (ondulação) e posterização; intensidade ligada à sanidade.
- Iluminação dia/noite com `CanvasModulate` e `PointLight2D`.
- Assets desenhados por mim ou obtidos exclusivamente no itch.io (créditos no site).

## 7. Escopo (MVP)
**Dentro:** 1 mapa, 1 casa, 3 noites, 2 recursos (madeira e sal grosso), 1 item-chave (machado), 1 tipo de criatura, HUD simples.
**Fora:** inventário em grade, crafting, save/load, vários mapas, pathfinding avançado.

## 8. Cronograma
Ver o GitHub Projects (Roadmap) do repositório.
