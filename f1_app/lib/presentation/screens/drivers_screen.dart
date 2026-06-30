import 'package:flutter/material.dart';

import '../../data/mock/f1_mock_data.dart';
import '../../data/repositories/team_repository.dart';
import '../widgets/driver_card.dart';

class DriversScreen extends StatelessWidget {
  const DriversScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teamRepo = TeamRepository();

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '🏎️ Pilotos',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE10600).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '🎨 DECORATOR PATTERN',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE10600),
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 8, 20, 4),
            child: Text(
              'Toque em um piloto para expandir e aplicar decoradores de telemetria',
              style: TextStyle(fontSize: 13, color: Colors.white38),
            ),
          ),
          const SizedBox(height: 8),
          // Driver list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 24),
              itemCount: mockDrivers.length,
              itemBuilder: (context, index) {
                final driver = mockDrivers[index];
                final team = teamRepo.getById(driver.teamId);
                return DriverCard(driver: driver, team: team);
              },
            ),
          ),
        ],
      ),
    );
  }
}
