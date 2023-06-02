import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:meuprimeirogame/components/background_component.dart';
import 'package:meuprimeirogame/components/santa_component.dart';
import 'package:meuprimeirogame/inputs/joystick.dart';

class GiftGrabGame extends FlameGame with DragCallbacks {
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    add(BackgroundComponent());
    add(SantaComponent(joystick: joystick));
    add(joystick);
  }
}
