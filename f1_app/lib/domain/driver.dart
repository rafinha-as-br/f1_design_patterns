class Driver {
  final String id;
  final String name;
  final int number;
  final String teamId;
  final String nationality;
  final String imageAsset;

  const Driver({
    required this.id,
    required this.name,
    required this.number,
    required this.teamId,
    required this.nationality,
    this.imageAsset = '',
  });
}
