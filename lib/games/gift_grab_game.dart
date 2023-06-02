import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:meuprimeirogame/components/background_component.dart';
import 'package:meuprimeirogame/components/gift_component.dart';
import 'package:meuprimeirogame/components/ice_component.dart';
import 'package:meuprimeirogame/components/santa_component.dart';
import 'package:meuprimeirogame/constants/globals.dart';
import 'package:meuprimeirogame/inputs/joystick.dart';

class GiftGrabGame extends FlameGame with DragCallbacks, HasCollisionDetection {
  int score = 0;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    //carrega componente do fundo
    add(BackgroundComponent());
    //carrega componente com o papai noel
    add(SantaComponent(joystick: joystick));
    //carrga caixa de presente na tela
    add(GiftComponent());
    //adiciona um joystick na tela
    add(joystick);

    //audio
    await FlameAudio.audioCache.loadAll([
      Globals.itemGrabSound,
    ]);

    //componente cubo de gelo
    add(IceComponent(startPosition: Vector2(200, 200)));
    add(IceComponent(startPosition: Vector2(size.x - 200, size.y - 200)));

    //Adiciona limites para bloco de gelo.
    add(ScreenHitbox());
  }
}
