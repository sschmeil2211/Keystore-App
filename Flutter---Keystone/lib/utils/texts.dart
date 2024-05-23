import 'package:keystore/models/models.dart';

String title(PinScreenType pinScreenType){
  switch(pinScreenType){
    case PinScreenType.create:
      return 'Create a pin';
    case PinScreenType.verify:
      return 'Verify your pin';
    case PinScreenType.validate:
      return 'Insert your pin';
  }
}