import '../../domain/team.dart';
import '../mock/f1_mock_data.dart';

class TeamRepository {
  List<Team> getAll() => mockTeams;

  Team? getById(String id) {
    try {
      return mockTeams.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }
}
