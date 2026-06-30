import '../../domain/car_setup.dart';
import 'car_setup_builder.dart';

class CarSetupDirector {
  final CarSetupBuilder _builder;

  CarSetupDirector(this._builder);

  CarSetup buildMonacoSetup() {
    return _builder
        .reset()
        .setFrontWing(45)
        .setRearWing(48)
        .setFuelLoad(95)
        .setTyreCompound('Soft')
        .build();
  }

  CarSetup buildMonzaSetup() {
    return _builder
        .reset()
        .setFrontWing(3)
        .setRearWing(5)
        .setFuelLoad(70)
        .setTyreCompound('Medium')
        .build();
  }

  CarSetup buildRainSetup() {
    return _builder
        .reset()
        .setFrontWing(30)
        .setRearWing(35)
        .setFuelLoad(85)
        .setTyreCompound('Wet')
        .build();
  }
}
