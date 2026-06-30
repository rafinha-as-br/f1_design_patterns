import '../../domain/driver.dart';
import '../mock/f1_mock_data.dart';

class DriverRepository {
  List<Driver> getAll() => mockDrivers;

  Driver? getById(String id) {
    try {
      return mockDrivers.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Driver> getByTeam(String teamId) {
    return mockDrivers.where((d) => d.teamId == teamId).toList();
  }
}
