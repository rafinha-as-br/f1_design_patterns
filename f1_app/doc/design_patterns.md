# Padrões de Projeto F1

## 1. Singleton (`RaceSessionManager`)

- **Categoria:** Criacional
- **Problema resolvido:** Garantir que o sistema tenha no máximo uma sessão de corrida ativa simultaneamente, fornecendo um ponto de acesso global a ela.
- **Aplicação no projeto F1:** Implementado no `RaceSessionManager` para gerenciar a sessão atual (Treino, Qualificação ou Corrida). Evita a criação acidental de múltiplas sessões rodando em paralelo, o que invalidaria a lógica de telemetria e cronometragem.
- **Justificativa da escolha:** O Singleton foi escolhido por ser o padrão ideal para coordenar o estado global e único da aplicação, como é o caso de um fim de semana de corrida.

**Diagrama UML simplificado:**
```text
+------------------------+
|   RaceSessionManager   |
+------------------------+
| - _instance: static    |
| - _currentSession      |
+------------------------+
| + factory()            |
| + startSession()       |
| + endSession()         |
| + hasActiveSession     |
+------------------------+
         ^
         | (retorna a mesma instância)
+------------------------+
|   RaceSessionScreen    |
|   HomeScreen           |
+------------------------+
```

---

## 2. Builder (`CarSetupBuilder`)

- **Categoria:** Criacional
- **Problema resolvido:** Construir objetos complexos passo a passo, evitando construtores gigantes e propensos a erro.
- **Aplicação no projeto F1:** Utilizado para criar o `CarSetup` do carro, que envolve configuração de asas, suspensão, pneus e combustível.
- **Justificativa da escolha:** O setup de um carro de F1 tem dezenas de parâmetros. O Builder permite uma construção limpa e possibilita que um `Director` crie "presets" rapidamente (ex: setup para Monza, setup para Mônaco).

**Diagrama UML simplificado:**
```text
+---------------------+     +-------------------------+
|   CarSetupBuilder   |---->|        CarSetup         |
+---------------------+     +-------------------------+
| - _engine           |     | + engine                |
| - _frontWingAngle   |     | + frontWingAngle        |
| - _rearWingAngle    |     | + rearWingAngle         |
| - _tyreCompound     |     | + tyreCompound          |
| - _fuelLoad         |     | + fuelLoad              |
+---------------------+     +-------------------------+
| + setEngine()       |
| + setFrontWing()    |
| + build(): CarSetup |
+---------------------+
```

---

## 3. Decorator (`TelemetryDecorator`)

- **Categoria:** Estrutural
- **Problema resolvido:** Adicionar responsabilidades ou dados a um objeto dinamicamente em tempo de execução, sem alterar sua classe original.
- **Aplicação no projeto F1:** Permite empilhar camadas de telemetria (Velocidade, Tempo de Volta, RPM) sobre o painel de um Piloto (`Driver`) na tela, dependendo das opções que o engenheiro ativa.
- **Justificativa da escolha:** Evita a criação de subclasses como `DriverWithSpeed`, `DriverWithSpeedAndLapTime`. O Decorator oferece a flexibilidade de adicionar e remover camadas visuais de dados dinamicamente.

**Diagrama UML simplificado:**
```text
+---------------------+
| <<Interface>>       |
| DriverComponent     |
+---------------------+
| + displayInfo()     |
+---------------------+
         ^
         |
+---------------------+      +--------------------------+
|     DriverBase      |      |     DriverDecorator      |
+---------------------+      +--------------------------+
| + displayInfo()     |<-----| - _wrapped: Component    |
+---------------------+      +--------------------------+
                                       ^
                                       |
                       +---------------+---------------+
                       |                               |
        +-----------------------------+ +-----------------------------+
        |   SpeedTelemetryDecorator   | |  LapTimeTelemetryDecorator  |
        +-----------------------------+ +-----------------------------+
        | + displayInfo()             | | + displayInfo()             |
        +-----------------------------+ +-----------------------------+
```

---

## 4. Strategy (`RaceStrategy`)

- **Categoria:** Comportamental
- **Problema resolvido:** Definir uma família de algoritmos, encapsulá-los e torná-los intercambiáveis, permitindo que o algoritmo varie independentemente dos clientes que o utilizam.
- **Aplicação no projeto F1:** Utilizado para definir as estratégias de pit stop e corrida (Agressiva, Conservadora, UnderCut). O engenheiro (`RaceStrategyContext`) pode trocar a estratégia do piloto no meio da corrida.
- **Justificativa da escolha:** Cada estratégia possui cálculos complexos e diferentes de quando parar nos boxes. Em vez de ter um grande `if/else` no controlador da corrida, cada lógica é isolada em sua própria classe.

**Diagrama UML simplificado:**
```text
+-----------------------+        +--------------------------+
| RaceStrategyContext   |        | <<Interface>>            |
+-----------------------+        | RaceStrategy             |
| - _strategy           |------->+--------------------------+
+-----------------------+        | + execute(driver, lap)   |
| + setStrategy()       |        +--------------------------+
| + executeStrategy()   |                   ^
+-----------------------+                   |
                                            |
                      +---------------------+-------------------+
                      |                     |                   |
            +-------------------+ +-------------------+ +------------------+
            | AggressiveStrategy| |ConservativeStrategy| | UnderCutStrategy |
            +-------------------+ +-------------------+ +------------------+
            | + execute()       | | + execute()       | | + execute()      |
            +-------------------+ +-------------------+ +------------------+
```
