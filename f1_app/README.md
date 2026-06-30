# 🏎️ F1 App - Flutter Project

Este é o diretório raiz do aplicativo Flutter que implementa os padrões de projeto para o domínio de Fórmula 1.

## 📁 Estrutura do Projeto

A arquitetura do aplicativo foi dividida em camadas lógicas para separar as responsabilidades e isolar a demonstração dos padrões:

*   **`lib/domain/`**: Contém as entidades de domínio puro (ex: `Driver`, `Team`, `CarSetup`, `RaceSession`), sem dependências de framework ou lógica complexa.
*   **`lib/patterns/`**: O coração deste projeto. Contém a implementação isolada dos 4 padrões de projeto exigidos:
    *   `creational/race_session_manager.dart` (Singleton)
    *   `creational/car_setup_builder.dart` (Builder)
    *   `structural/telemetry_decorator.dart` (Decorator)
    *   `behavioral/race_strategy.dart` (Strategy)
*   **`lib/data/`**: Contém os dados falsos (*mocks*) utilizados no aplicativo (`f1_mock_data.dart`) e repositórios simples para acessá-los.
*   **`lib/presentation/`**: Toda a interface de usuário (UI), dividida em:
    *   `screens/`: Telas completas do aplicativo (Home, Drivers, Setup, Race Session).
    *   `widgets/`: Componentes visuais reutilizáveis (Cards, Selectors).
*   **`doc/`**: Contém a documentação técnica dos padrões implementados (`design_patterns.md`).

## 🛠️ Tecnologias Utilizadas

*   **Flutter & Dart**: O projeto foi construído nativamente com o SDK do Flutter.
*   **Material Design 3**: Utilizado para a base visual, customizado com um tema escuro e cores inspiradas no universo da F1.
*   *Nenhuma dependência externa adicional (packages)* foi utilizada, garantindo que o foco permaneça 100% no código dos padrões de projeto e nas ferramentas nativas do Dart.

## ▶️ Como Rodar

Para executar este projeto, certifique-se de estar dentro desta pasta (`f1_app`) no seu terminal:

```bash
# 1. Baixe as dependências internas do Flutter
flutter pub get

# 2. Execute o app no dispositivo selecionado (Emulador, Chrome, Windows, etc.)
flutter run
```

Para voltar à documentação principal do repositório, consulte o `README.md` na pasta raiz do projeto.
