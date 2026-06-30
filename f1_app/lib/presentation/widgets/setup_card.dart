import 'package:flutter/material.dart';

import '../../domain/car_setup.dart';

class SetupCard extends StatelessWidget {
  final CarSetup setup;

  const SetupCard({super.key, required this.setup});

  @override
  Widget build(BuildContext context) {
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
          // Title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF00C853).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Color(0xFF00C853),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Setup Construído',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFF2E2E2E), height: 1),
          const SizedBox(height: 16),

          _buildRow('Motor', setup.engine, Icons.engineering),
          _buildRow(
            'Asa Dianteira',
            '${setup.frontWingAngle}°',
            Icons.arrow_upward,
          ),
          _buildRow(
            'Asa Traseira',
            '${setup.rearWingAngle}°',
            Icons.arrow_downward,
          ),
          _buildRow('Pneu', setup.tyreCompound, Icons.circle_outlined),
          _buildRow(
            'Combustível',
            '${setup.fuelLoad.toStringAsFixed(1)} kg',
            Icons.local_gas_station,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.white38),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white54,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
