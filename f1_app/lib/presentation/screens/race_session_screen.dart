import 'package:flutter/material.dart';

import '../../domain/race_session.dart';
import '../../data/mock/f1_mock_data.dart';
import '../../patterns/creational/race_session_manager.dart';
import '../../patterns/behavioral/race_strategy.dart';
import '../widgets/strategy_selector.dart';

class RaceSessionScreen extends StatefulWidget {
  const RaceSessionScreen({super.key});

  @override
  State<RaceSessionScreen> createState() => _RaceSessionScreenState();
}

class _RaceSessionScreenState extends State<RaceSessionScreen> {
  final _sessionManager = RaceSessionManager();

  // Strategy state
  final List<RaceStrategy> _strategies = [
    AggressiveStrategy(),
    ConservativeStrategy(),
    UnderCutStrategy(),
  ];
  late final _context = RaceStrategyContext(_strategies.first);

  RaceStrategy? _selectedStrategy;
  String? _selectedDriverId;
  int _currentLap = 10;
  int _totalLaps = 57;
  String? _strategyResult;

  // Circuit for new session
  String _selectedCircuit = mockCircuits.first;

  void _startSession() {
    showDialog(
      context: context,
      builder: (ctx) {
        String circuit = _selectedCircuit;
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1E1E1E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              title: const Text(
                'Iniciar Sessão',
                style: TextStyle(color: Colors.white),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF141414),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF2E2E2E)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: circuit,
                        isExpanded: true,
                        dropdownColor: const Color(0xFF1E1E1E),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        items: mockCircuits.map((c) {
                          return DropdownMenuItem(
                            value: c,
                            child: Text(
                              c,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (v) {
                          if (v != null) {
                            setDialogState(() => circuit = v);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final session = RaceSession(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      circuitName: circuit,
                      type: SessionType.race,
                      startTime: DateTime.now(),
                    );
                    try {
                      _sessionManager.startSession(session);
                      setState(() {});
                      Navigator.pop(ctx);
                    } catch (e) {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                          backgroundColor: const Color(0xFFFF5252),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C853),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Iniciar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _endSession() {
    _sessionManager.endSession();
    setState(() {});
  }

  void _executeStrategy() {
    if (_selectedDriverId == null || _selectedStrategy == null) return;

    final driver = mockDrivers.firstWhere((d) => d.id == _selectedDriverId);
    _context.setStrategy(_selectedStrategy!);
    final result = _context.executeStrategy(driver, _currentLap, _totalLaps);

    setState(() => _strategyResult = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '🏁 Sessão de Corrida',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ── SINGLETON SECTION ──
          _buildSectionHeader('SINGLETON PATTERN', const Color(0xFF00C853)),
          const SizedBox(height: 16),

          // Session status card
          _buildSessionStatusCard(),
          const SizedBox(height: 16),

          // Singleton instance card
          _buildSingletonInstanceCard(),
          const SizedBox(height: 16),

          // Session buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed:
                      _sessionManager.hasActiveSession ? null : _startSession,
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: const Text('Iniciar Sessão'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C853),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFF2E2E2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed:
                      _sessionManager.hasActiveSession ? _endSession : null,
                  icon: const Icon(Icons.stop, size: 18),
                  label: const Text('Encerrar Sessão'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5252),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFF2E2E2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // ── STRATEGY SECTION ──
          _buildSectionHeader('STRATEGY PATTERN', const Color(0xFFFFAB00)),
          const SizedBox(height: 16),

          // Driver selector
          const Text(
            'Piloto',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2E2E2E)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedDriverId,
                isExpanded: true,
                hint: const Text(
                  'Selecione um piloto',
                  style: TextStyle(color: Colors.white38),
                ),
                dropdownColor: const Color(0xFF1E1E1E),
                style: const TextStyle(fontSize: 14, color: Colors.white),
                items: mockDrivers.map((d) {
                  return DropdownMenuItem(
                    value: d.id,
                    child: Text('${d.nationality} ${d.name}'),
                  );
                }).toList(),
                onChanged: (v) => setState(() => _selectedDriverId = v),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Strategy selector
          const Text(
            'Estratégia',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          StrategySelector(
            strategies: _strategies,
            selected: _selectedStrategy,
            onSelected: (s) => setState(() => _selectedStrategy = s),
          ),
          const SizedBox(height: 20),

          // Lap inputs
          Row(
            children: [
              Expanded(
                child: _buildLapField(
                  'Volta atual',
                  _currentLap,
                  (v) => setState(() => _currentLap = v),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildLapField(
                  'Total de voltas',
                  _totalLaps,
                  (v) => setState(() => _totalLaps = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Execute button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: (_selectedDriverId != null && _selectedStrategy != null)
                  ? _executeStrategy
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE10600),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFF2E2E2E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Executar Estratégia',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Strategy result
          if (_strategyResult != null)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Container(
                key: ValueKey(_strategyResult),
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF2E2E2E)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.analytics,
                          color: Color(0xFFFFAB00),
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Resultado Estratégico',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: Color(0xFF2E2E2E), height: 1),
                    const SizedBox(height: 12),
                    Text(
                      _strategyResult!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSessionStatusCard() {
    final session = _sessionManager.currentSession;
    final isActive = _sessionManager.hasActiveSession;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive
              ? const Color(0xFF00C853).withValues(alpha: 0.3)
              : const Color(0xFF2E2E2E),
        ),
      ),
      child: isActive
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00C853),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Sessão Ativa',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00C853),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildInfoRow('Circuito', session!.circuitName),
                _buildInfoRow('Status', 'Running'),
                _buildInfoRow(
                  'Tipo',
                  session.type.name.toUpperCase(),
                ),
              ],
            )
          : const Row(
              children: [
                Icon(Icons.circle_outlined, color: Colors.white24, size: 10),
                SizedBox(width: 8),
                Text(
                  'Nenhuma sessão ativa',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSingletonInstanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2E2E2E)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'RaceSessionManager',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            'Hash',
            _sessionManager.hashCode.toString(),
          ),
          const SizedBox(height: 8),
          const Text(
            'Mesmo objeto em todas as telas',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white38,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white38,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLapField(
    String label,
    int value,
    ValueChanged<int> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white54,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF2E2E2E)),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: value > 1
                    ? () => onChanged(value - 1)
                    : null,
                icon: const Icon(Icons.remove, size: 18),
                color: Colors.white54,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    value.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => onChanged(value + 1),
                icon: const Icon(Icons.add, size: 18),
                color: Colors.white54,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
