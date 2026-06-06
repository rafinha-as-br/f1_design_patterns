import 'dart:ui';

class Team {
  final String id;
  final String name;
  final String engine;
  final String chassis;
  final Color primaryColor;

  const Team({
    required this.id,
    required this.name,
    required this.engine,
    required this.chassis,
    required this.primaryColor,
  });
}
