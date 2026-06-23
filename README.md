# 🏎️ F1 Design Patterns

## Integrantes
- `Rafael Antunes Souza`
- `Daniel Mariano Marques`


## 📺 Apresentação
🔗 Link do vídeo no drive: ``

---

## 📝 Descrição do Projeto

Este projeto é uma aplicação Flutter que demonstra de forma visual e interativa **4 padrões de projeto de software**, aplicados ao domínio automobilístico da Fórmula 1. 

A aplicação não consome APIs externas, utilizando dados *mock* para focar 100% na implementação técnica dos padrões e na sua demonstração pela interface de usuário.

---

## 🧩 Padrões Utilizados e Localização

| Padrão | Categoria | Descrição no Domínio | Arquivo |
|--------|-----------|----------------------|---------|
| **Singleton** | Criacional | Garante a existência de uma única sessão de corrida ativa no sistema (`RaceSessionManager`). | `lib/patterns/creational/race_session_manager.dart` |
| **Builder** | Criacional | Montagem passo a passo da configuração complexa de um carro (`CarSetupBuilder`). | `lib/patterns/creational/car_setup_builder.dart` |
| **Decorator** | Estrutural | Adição dinâmica de camadas de dados de telemetria aos pilotos na UI (`TelemetryDecorator`). | `lib/patterns/structural/telemetry_decorator.dart` |
| **Strategy** | Comportamental | Troca de estratégias de pit stop em tempo de execução (`RaceStrategy`). | `lib/patterns/behavioral/race_strategy.dart` |

---

## 🚀 Como Executar

O projeto foi desenvolvido para funcionar nativamente com o Flutter SDK, sem dependências de pacotes de terceiros.

1. Navegue até o diretório do projeto:
```bash
cd f1_app
```

2. Obtenha as dependências (neste caso, apenas dependências internas do Flutter):
```bash
flutter pub get
```

3. Execute a aplicação (em emulador, dispositivo físico ou Chrome):
```bash
flutter run
```

---

**Disciplina:** Padrões de Projeto de Software — IFSC Câmpus Gaspar
