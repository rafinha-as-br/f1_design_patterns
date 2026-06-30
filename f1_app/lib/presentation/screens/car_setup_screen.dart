import 'package:flutter/material.dart';

import '../../domain/car_setup.dart';
import '../../patterns/creational/car_setup_builder.dart';
import '../../patterns/creational/car_setup_director.dart';
import '../widgets/setup_card.dart';

class CarSetupScreen extends StatefulWidget {
  const CarSetupScreen({super.key});

  @override
  State<CarSetupScreen> createState() => _CarSetupScreenState();
}

class _CarSetupScreenState extends State<CarSetupScreen> {
  final _builder = CarSetupBuilder();
  late final _director = CarSetupDirector(_builder);

  int _frontWing = 15;
  int _rearWing = 15;
  double _fuelLoad = 80.0;
  String _tyreCompound = 'Medium';

  CarSetup? _builtSetup;

  final List<String> _tyreOptions = [
    'Soft',
    'Medium',
    'Hard',
    'Inter',
    'Wet',
  ];

  void _applyPreset(String name) {
    late CarSetup preset;
    switch (name) {
      case 'monaco':
        preset = _director.buildMonacoSetup();
        break;
      case 'monza':
        preset = _director.buildMonzaSetup();
        break;
      case 'rain':
        preset = _director.buildRainSetup();
        break;
    }
    setState(() {
      _frontWing = preset.frontWingAngle;
      _rearWing = preset.rearWingAngle;
      _fuelLoad = preset.fuelLoad;
      _tyreCompound = preset.tyreCompound;
      _builtSetup = preset;
    });
  }

  void _buildSetup() {
    final setup = _builder
        .reset()
        .setFrontWing(_frontWing)
        .setRearWing(_rearWing)
        .setFuelLoad(_fuelLoad)
        .setTyreCompound(_tyreCompound)
        .build();

    setState(() => _builtSetup = setup);
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
          '🔧 Builder de Setup',
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
          // Pattern label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFF8000).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '🏗️ BUILDER PATTERN',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF8000),
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Configure cada parâmetro e monte o setup do carro',
            style: TextStyle(fontSize: 13, color: Colors.white38),
          ),
          const SizedBox(height: 24),

          // Preset buttons
          const Text(
            'Presets',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildPresetButton('Setup Mônaco', 'monaco', const Color(0xFFE10600)),
              const SizedBox(width: 8),
              _buildPresetButton('Setup Monza', 'monza', const Color(0xFFFF8000)),
              const SizedBox(width: 8),
              _buildPresetButton('Setup Chuva', 'rain', const Color(0xFF29B6F6)),
            ],
          ),
          const SizedBox(height: 32),

          // Controls section
          _buildSectionTitle('Asa Dianteira'),
          _buildSlider(
            value: _frontWing.toDouble(),
            min: 0,
            max: 50,
            label: '$_frontWing°',
            onChanged: (v) => setState(() => _frontWing = v.round()),
          ),
          const SizedBox(height: 20),

          _buildSectionTitle('Asa Traseira'),
          _buildSlider(
            value: _rearWing.toDouble(),
            min: 0,
            max: 50,
            label: '$_rearWing°',
            onChanged: (v) => setState(() => _rearWing = v.round()),
          ),
          const SizedBox(height: 20),

          _buildSectionTitle('Carga de Combustível'),
          _buildSlider(
            value: _fuelLoad,
            min: 0,
            max: 110,
            label: '${_fuelLoad.toStringAsFixed(1)} kg',
            onChanged: (v) => setState(() => _fuelLoad = v),
          ),
          const SizedBox(height: 20),

          _buildSectionTitle('Composto de Pneu'),
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
                value: _tyreCompound,
                isExpanded: true,
                dropdownColor: const Color(0xFF1E1E1E),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white54),
                items: _tyreOptions.map((t) {
                  return DropdownMenuItem(
                    value: t,
                    child: Text(t),
                  );
                }).toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _tyreCompound = v);
                },
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Build button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _buildSetup,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE10600),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Montar Setup',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Result
          if (_builtSetup != null)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: SetupCard(
                key: ValueKey(_builtSetup.hashCode),
                setup: _builtSetup!,
              ),
            ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
    );
  }

  Widget _buildSlider({
    required double value,
    required double min,
    required double max,
    required String label,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${min.toInt()}',
              style: const TextStyle(fontSize: 11, color: Colors.white38),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE10600),
              ),
            ),
            Text(
              '${max.toInt()}',
              style: const TextStyle(fontSize: 11, color: Colors.white38),
            ),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: const Color(0xFFE10600),
            inactiveTrackColor: const Color(0xFF2E2E2E),
            thumbColor: const Color(0xFFE10600),
            overlayColor: const Color(0xFFE10600).withValues(alpha: 0.2),
            trackHeight: 4,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildPresetButton(String label, String preset, Color color) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => _applyPreset(preset),
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color.withValues(alpha: 0.5)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
