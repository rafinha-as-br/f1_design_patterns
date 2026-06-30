class LapTelemetry {
  final int lapNumber;
  final double topSpeed;
  final double bestLapTime;
  final int maxRpm;
  final int gear;

  const LapTelemetry({
    required this.lapNumber,
    required this.topSpeed,
    required this.bestLapTime,
    required this.maxRpm,
    required this.gear,
  });
}
