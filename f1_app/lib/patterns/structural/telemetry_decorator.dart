import '../../domain/driver.dart';
import '../../domain/lap_telemetry.dart';

// Interface componente base
abstract class DriverComponent {
  String get displayName;
  String displayInfo();
}

// Componente concreto — piloto "puro"
class DriverBase implements DriverComponent {
  final Driver driver;

  DriverBase(this.driver);

  @override
  String get displayName => driver.name;

  @override
  String displayInfo() => '🏎️ ${driver.name} — #${driver.number}';
}

// Decorator base abstrato
abstract class DriverDecorator implements DriverComponent {
  final DriverComponent _wrapped;

  DriverDecorator(this._wrapped);

  @override
  String get displayName => _wrapped.displayName;
}

// Decorator concreto 1 — adiciona velocidade máxima
class SpeedTelemetryDecorator extends DriverDecorator {
  final LapTelemetry telemetry;

  SpeedTelemetryDecorator(super.wrapped, this.telemetry);

  @override
  String displayInfo() =>
      '${_wrapped.displayInfo()} | ⚡ Top Speed: ${telemetry.topSpeed} km/h';
}

// Decorator concreto 2 — adiciona melhor volta
class LapTimeTelemetryDecorator extends DriverDecorator {
  final LapTelemetry telemetry;

  LapTimeTelemetryDecorator(super.wrapped, this.telemetry);

  @override
  String displayInfo() =>
      '${_wrapped.displayInfo()} | 🕐 Best Lap: ${telemetry.bestLapTime}s';
}
