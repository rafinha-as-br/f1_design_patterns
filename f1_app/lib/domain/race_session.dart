enum SessionType { practice, qualifying, race }

enum SessionStatus { pending, active, finished }

class RaceSession {
  final String id;
  final String circuitName;
  final SessionType type;
  final DateTime startTime;
  SessionStatus status;

  RaceSession({
    required this.id,
    required this.circuitName,
    required this.type,
    required this.startTime,
    this.status = SessionStatus.pending,
  });
}
