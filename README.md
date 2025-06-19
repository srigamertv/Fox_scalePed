# 🧍‍♂️ Fox_scalePed - Controle de Escala do Ped no FiveM (vRP)

Um simples e poderoso script para FiveM baseado no vRP, que permite aos jogadores alterarem dinamicamente o tamanho do seu personagem (Ped). Ideal para modos criativos, eventos especiais ou efeitos cômicos no servidor.

---

## ✨ Funcionalidades

- Comando personalizado para alterar escala via `chat`.
- Modos rápidos com comandos `/gigante`, `/pequeno` e `/normal`.
- Aplicação suave de escala com transição visual.
- Limites de escala configuráveis.
- Reset automático ao parar o recurso.

---

## ⚙️ Configuração

A configuração é feita diretamente no arquivo `config.lua`:

```lua
Config.commandName = "pedscale" -- Comando principal
Config.defaultScale = 1.0 -- Escala padrão
Config.scaleStep = 0.1 -- Passo de ajuste
Config.scaleLimits = { min = 0.1, max = 2.5 } -- Limites
Config.scaleReset = 1.0
Config.scaleGigante = 2.5
Config.scalePequeno = 0.1
```

🧠 Como Funciona
O sistema utiliza SetEntityMatrix para alterar a matriz do ped, escalando suavemente com base no tempo e movimentação do jogador.

- Ao digitar o comando configurado (ex: /pedscale), o jogador informa o valor desejado (de 0.1 a 2.5).

- A escala é aplicada com transição e offset de altura para evitar afundamento no chão.

- Comandos rápidos também estão disponíveis:

    - /gigante: aplica a escala máxima (2.5)

    - /pequeno: aplica a escala mínima (0.1)

    - /normal: reseta o tamanho para o padrão (1.0)

A escala também pode ser aplicada via evento:
```lua
TriggerClientEvent("um-ped-scale:applyScale", source, escalaDesejada)
```

🔧 Instalação
1. Coloque os arquivos do script na pasta resources/[local]/Fox_scalePed.

2. Adicione ao seu server.cfg:
```ruby
ensure Fox_scalePed
```
3. Certifique-se de que o vRP está corretamente instalado e funcionando.

Edite o Config.commandName se quiser mudar o nome do comando principal.


🧪 Comandos Disponíveis:

| Comando     | Descrição                                  |
| ----------- | ------------------------------------------ |
| `/pedscale` | Abre prompt para inserir a escala desejada |
| `/gigante`  | Aplica escala máxima (`2.5`)               |
| `/pequeno`  | Aplica escala mínima (`0.1`)               |
| `/normal`   | Reseta a escala para `1.0`                 |


🙋‍♂️ Créditos

Desenvolvido por SR.IGAMER TV | FOX.

Creditos ao: https://github.com/alp1x/um-ped-scale - graças a ele estarei liberando isso para vocês!!!

Script simples, funcional e direto ao ponto — com objetivo de ajudar a comunidade FiveM a implementar algo criativo no RP ou servidor casual.


🛡️ Licença
Este script é distribuído gratuitamente para fins educacionais e comunitários.

Sinta-se livre para modificar, mas dê os devidos créditos. Não venda este script

