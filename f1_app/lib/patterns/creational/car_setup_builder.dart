import '../../domain/car_setup.dart';

class CarSetupBuilder {
  String _engine = 'V6 Hybrid 1.6L';
  int _frontWingAngle = 15;
  int _rearWingAngle = 15;
  String _tyreCompound = 'Medium';
  double _fuelLoad = 80.0;

  CarSetupBuilder setEngine(String engine) {
    _engine = engine;
    return this;
  }

  CarSetupBuilder setFrontWing(int angle) {
    _frontWingAngle = angle.clamp(0, 50);
    return this;
  }

  CarSetupBuilder setRearWing(int angle) {
    _rearWingAngle = angle.clamp(0, 50);
    return this;
  }

  CarSetupBuilder setTyreCompound(String compound) {
    _tyreCompound = compound;
    return this;
  }

  CarSetupBuilder setFuelLoad(double kg) {
    _fuelLoad = kg.clamp(0.0, 110.0);
    return this;
  }

  CarSetupBuilder reset() {
    _engine = 'V6 Hybrid 1.6L';
    _frontWingAngle = 15;
    _rearWingAngle = 15;
    _tyreCompound = 'Medium';
    _fuelLoad = 80.0;
    return this;
  }

  CarSetup build() {
    return CarSetup(
      engine: _engine,
      frontWingAngle: _frontWingAngle,
      rearWingAngle: _rearWingAngle,
      tyreCompound: _tyreCompound,
      fuelLoad: _fuelLoad,
    );
  }
}
