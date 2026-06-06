import 'package:flutter/material.dart';

import '../../patterns/behavioral/race_strategy.dart';

class StrategySelector extends StatelessWidget {
  final List<RaceStrategy> strategies;
  final RaceStrategy? selected;
  final ValueChanged<RaceStrategy> onSelected;

  const StrategySelector({
    super.key,
    required this.strategies,
    required this.selected,
    required this.onSelected,
  });

  IconData _iconForStrategy(RaceStrategy strategy) {
    if (strategy is AggressiveStrategy) return Icons.local_fire_department;
    if (strategy is ConservativeStrategy) return Icons.shield;
    if (strategy is UnderCutStrategy) return Icons.bolt;
    return Icons.straighten;
  }

  Color _colorForStrategy(RaceStrategy strategy) {
    if (strategy is AggressiveStrategy) return const Color(0xFFFF5252);
    if (strategy is ConservativeStrategy) return const Color(0xFF29B6F6);
    if (strategy is UnderCutStrategy) return const Color(0xFFFFAB00);
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: strategies.map((strategy) {
        final isSelected = selected == strategy;
        final color = _colorForStrategy(strategy);

        return Expanded(
          child: GestureDetector(
            onTap: () => onSelected(strategy),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected
                    ? color.withValues(alpha: 0.1)
                    : const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? const Color(0xFFE10600) : const Color(0xFF2E2E2E),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    _iconForStrategy(strategy),
                    color: color,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    strategy.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    strategy.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white38,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
