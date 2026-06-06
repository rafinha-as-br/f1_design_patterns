import 'package:flutter/material.dart';

import '../../patterns/creational/race_session_manager.dart';
import 'drivers_screen.dart';
import 'car_setup_screen.dart';
import 'race_session_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _sessionManager = RaceSessionManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Row(
          children: [
            Text('🏎️', style: TextStyle(fontSize: 24)),
            SizedBox(width: 8),
            Text(
              'F1 Design Patterns',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          // Badge de sessão ativa (Singleton)
          if (_sessionManager.hasActiveSession)
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF00C853).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFF00C853).withValues(alpha: 0.3),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, color: Color(0xFF00C853), size: 8),
                  SizedBox(width: 6),
                  Text(
                    'Sessão Ativa',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF00C853),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Padrões de Projeto',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Selecione uma seção para explorar',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: [
                  _buildNavCard(
                    context,
                    icon: '🏎️',
                    title: 'Pilotos',
                    pattern: 'Decorator Pattern',
                    description: 'Telemetria dinâmica sobre pilotos',
                    color: const Color(0xFFE10600),
                    onTap: () => _navigateTo(context, const DriversScreen()),
                  ),
                  const SizedBox(height: 16),
                  _buildNavCard(
                    context,
                    icon: '🔧',
                    title: 'Configuração do Carro',
                    pattern: 'Builder Pattern',
                    description: 'Monte setups passo a passo',
                    color: const Color(0xFFFF8000),
                    onTap: () => _navigateTo(context, const CarSetupScreen()),
                  ),
                  const SizedBox(height: 16),
                  _buildNavCard(
                    context,
                    icon: '🏁',
                    title: 'Sessão de Corrida',
                    pattern: 'Singleton + Strategy',
                    description: 'Gerencie sessões e estratégias',
                    color: const Color(0xFF00D2BE),
                    onTap: () => _navigateTo(
                      context,
                      const RaceSessionScreen(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    ).then((_) => setState(() {})); // Refresh badge on return
  }

  Widget _buildNavCard(
    BuildContext context, {
    required String icon,
    required String title,
    required String pattern,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF2E2E2E)),
          ),
          child: Row(
            children: [
              // Icon circle
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(icon, style: const TextStyle(fontSize: 28)),
                ),
              ),
              const SizedBox(width: 20),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        pattern,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: color,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.white24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
