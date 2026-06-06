import 'dart:ui';

import '../../domain/driver.dart';
import '../../domain/team.dart';
import '../../domain/lap_telemetry.dart';

// Pilotos
final List<Driver> mockDrivers = [
  const Driver(
    id: 'd1',
    name: 'Max Verstappen',
    number: 1,
    teamId: 't1',
    nationality: '🇳🇱',
  ),
  const Driver(
    id: 'd2',
    name: 'Lewis Hamilton',
    number: 44,
    teamId: 't2',
    nationality: '🇬🇧',
  ),
  const Driver(
    id: 'd3',
    name: 'Charles Leclerc',
    number: 16,
    teamId: 't3',
    nationality: '🇲🇨',
  ),
  const Driver(
    id: 'd4',
    name: 'Lando Norris',
    number: 4,
    teamId: 't4',
    nationality: '🇬🇧',
  ),
  const Driver(
    id: 'd5',
    name: 'Carlos Sainz',
    number: 55,
    teamId: 't3',
    nationality: '🇪🇸',
  ),
];

// Equipes
final List<Team> mockTeams = [
  const Team(
    id: 't1',
    name: 'Red Bull Racing',
    engine: 'Honda RBPT',
    chassis: 'RB20',
    primaryColor: Color(0xFF1E3A5F),
  ),
  const Team(
    id: 't2',
    name: 'Mercedes-AMG',
    engine: 'Mercedes',
    chassis: 'W15',
    primaryColor: Color(0xFF00D2BE),
  ),
  const Team(
    id: 't3',
    name: 'Scuderia Ferrari',
    engine: 'Ferrari',
    chassis: 'SF-24',
    primaryColor: Color(0xFFDC0000),
  ),
  const Team(
    id: 't4',
    name: 'McLaren',
    engine: 'Mercedes',
    chassis: 'MCL38',
    primaryColor: Color(0xFFFF8000),
  ),
];

// Circuitos
final List<String> mockCircuits = [
  'Autodromo di Monza',
  'Circuit de Monaco',
  'Silverstone Circuit',
  'Circuit de Spa-Francorchamps',
  'Interlagos — Autódromo José Carlos Pace',
];

// Telemetria por piloto
final Map<String, LapTelemetry> mockTelemetry = {
  'd1': const LapTelemetry(
    lapNumber: 42,
    topSpeed: 358.0,
    bestLapTime: 78.725,
    maxRpm: 15200,
    gear: 8,
  ),
  'd2': const LapTelemetry(
    lapNumber: 38,
    topSpeed: 341.0,
    bestLapTime: 79.102,
    maxRpm: 14800,
    gear: 8,
  ),
  'd3': const LapTelemetry(
    lapNumber: 40,
    topSpeed: 344.0,
    bestLapTime: 79.401,
    maxRpm: 15000,
    gear: 8,
  ),
  'd4': const LapTelemetry(
    lapNumber: 35,
    topSpeed: 347.0,
    bestLapTime: 79.550,
    maxRpm: 14900,
    gear: 8,
  ),
  'd5': const LapTelemetry(
    lapNumber: 37,
    topSpeed: 340.0,
    bestLapTime: 79.890,
    maxRpm: 14700,
    gear: 8,
  ),
};
