import '../../domain/driver.dart';

// Interface Strategy
abstract class RaceStrategy {
  String get name;
  String get description;
  String execute(Driver driver, int currentLap, int totalLaps);
}

// Estratégia concreta 1 — Agressiva
class AggressiveStrategy implements RaceStrategy {
  @override
  String get name => 'Agressiva';

  @override
  String get description => 'Pit stop cedo, pneu macio, atacar posições';

  @override
  String execute(Driver driver, int currentLap, int totalLaps) {
    final pitLap = (totalLaps * 0.30).round();
    return '${driver.name}: Pit stop na volta $pitLap com pneu MACIO. '
        'Meta: undercut do concorrente.';
  }
}

// Estratégia concreta 2 — Conservadora
class ConservativeStrategy implements RaceStrategy {
  @override
  String get name => 'Conservadora';

  @override
  String get description => 'Pit stop tardio, pneu duro, gerenciar pneus';

  @override
  String execute(Driver driver, int currentLap, int totalLaps) {
    final pitLap = (totalLaps * 0.65).round();
    return '${driver.name}: Pit stop na volta $pitLap com pneu DURO. '
        'Meta: minimizar o tempo em pista com pneus novos.';
  }
}

// Estratégia concreta 3 — UnderCut
class UnderCutStrategy implements RaceStrategy {
  @override
  String get name => 'UnderCut';

  @override
  String get description => 'Pit stop antecipado para ganhar posição na saída';

  @override
  String execute(Driver driver, int currentLap, int totalLaps) {
    final pitLap = currentLap + 2;
    return '${driver.name}: Pit stop IMEDIATO (volta $pitLap) com pneu MACIO. '
        'Meta: sair na frente após pit do adversário.';
  }
}

// Context — usa a Strategy injetada
class RaceStrategyContext {
  RaceStrategy _strategy;

  RaceStrategyContext(this._strategy);

  void setStrategy(RaceStrategy strategy) {
    _strategy = strategy;
  }

  RaceStrategy get currentStrategy => _strategy;

  String executeStrategy(Driver driver, int currentLap, int totalLaps) {
    return _strategy.execute(driver, currentLap, totalLaps);
  }
}
