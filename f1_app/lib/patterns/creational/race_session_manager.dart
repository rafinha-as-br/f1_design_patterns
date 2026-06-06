import '../../domain/race_session.dart';

class RaceSessionManager {
  // construtor privado
  RaceSessionManager._internal();

  // instância única
  static final RaceSessionManager _instance = RaceSessionManager._internal();

  // factory retorna sempre a mesma instância
  factory RaceSessionManager() => _instance;

  // estado interno
  RaceSession? _currentSession;

  RaceSession? get currentSession => _currentSession;

  void startSession(RaceSession session) {
    if (_currentSession != null &&
        _currentSession!.status == SessionStatus.active) {
      throw StateError(
        'Já existe uma sessão ativa. Encerre-a antes de iniciar outra.',
      );
    }
    _currentSession = session;
    _currentSession!.status = SessionStatus.active;
  }

  void endSession() {
    _currentSession?.status = SessionStatus.finished;
    _currentSession = null;
  }

  bool get hasActiveSession => _currentSession != null;
}
