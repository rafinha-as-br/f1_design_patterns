import 'package:flutter/material.dart';

import '../../domain/driver.dart';
import '../../domain/team.dart';
import '../../domain/lap_telemetry.dart';
import '../../data/mock/f1_mock_data.dart';
import '../../patterns/structural/telemetry_decorator.dart';

class DriverCard extends StatefulWidget {
  final Driver driver;
  final Team? team;

  const DriverCard({super.key, required this.driver, this.team});

  @override
  State<DriverCard> createState() => _DriverCardState();
}

class _DriverCardState extends State<DriverCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool _showSpeed = false;
  bool _showLapTime = false;

  LapTelemetry? get _telemetry => mockTelemetry[widget.driver.id];

  String _buildDecoratedInfo() {
    DriverComponent component = DriverBase(widget.driver);

    final telemetry = _telemetry;
    if (telemetry == null) return component.displayInfo();

    if (_showSpeed) {
      component = SpeedTelemetryDecorator(component, telemetry);
    }
    if (_showLapTime) {
      component = LapTimeTelemetryDecorator(component, telemetry);
    }

    return component.displayInfo();
  }

  @override
  Widget build(BuildContext context) {
    final teamColor = widget.team?.primaryColor ?? const Color(0xFFE10600);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF2E2E2E),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  children: [
                    // Team color indicator
                    Container(
                      width: 4,
                      height: 48,
                      decoration: BoxDecoration(
                        color: teamColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Driver info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.driver.nationality,
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  widget.driver.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '#${widget.driver.number}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: teamColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Team name
                    if (widget.team != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: teamColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: teamColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          widget.team!.name,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: teamColor,
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.white54,
                    ),
                  ],
                ),

                // Expanded content — Decorator demo
                if (_isExpanded) ...[
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFF2E2E2E), height: 1),
                  const SizedBox(height: 16),

                  // Decorator label
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
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
                  const SizedBox(height: 12),

                  // Telemetry toggles (checkboxes)
                  _buildCheckbox(
                    'Exibir velocidade',
                    _showSpeed,
                    (v) => setState(() => _showSpeed = v ?? false),
                  ),
                  _buildCheckbox(
                    'Exibir tempo de volta',
                    _showLapTime,
                    (v) => setState(() => _showLapTime = v ?? false),
                  ),

                  const SizedBox(height: 12),

                  // Decorated output
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      key: ValueKey('$_showSpeed-$_showLapTime'),
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF141414),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF2E2E2E)),
                      ),
                      child: Text(
                        _buildDecoratedInfo(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),

                  // Telemetry raw data
                  if (_telemetry != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildTelemetryStat(
                          'RPM',
                          _telemetry!.maxRpm.toString(),
                          Icons.speed,
                        ),
                        _buildTelemetryStat(
                          'Marcha',
                          _telemetry!.gear.toString(),
                          Icons.settings,
                        ),
                        _buildTelemetryStat(
                          'Volta',
                          _telemetry!.lapNumber.toString(),
                          Icons.flag,
                        ),
                      ],
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox(
    String label,
    bool value,
    ValueChanged<bool?> onChanged,
  ) {
    return Row(
      children: [
        SizedBox(
          height: 32,
          width: 32,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFE10600),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildTelemetryStat(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, size: 16, color: Colors.white38),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.white38),
            ),
          ],
        ),
      ),
    );
  }
}
