import 'dart:async';

import 'package:flame/components.dart';
import 'package:meuprimeirogame/constants/globals.dart';

import '../games/gift_grab_game.dart';

enum MovementState {
  idle,
  slideLeft,
  slideRight,
}

class SantaComponent extends SpriteGroupComponent<MovementState>
    with HasGameRef<GiftGrabGame> {
  /// Height of the sprite.
  final double _spriteHeight = 100;
  final double _speed = 500;

  /// Screen boundries.
  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;

  late JoystickComponent joystick;

  SantaComponent({required this.joystick});

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    Sprite santaIdle = await gameRef.loadSprite(Globals.santaIdle);
    Sprite santaLeftSlide =
        await gameRef.loadSprite(Globals.santaSlideLeftSprite);
    Sprite santaRightSlide =
        await gameRef.loadSprite(Globals.santaSlideRightSprite);

    // Cada estado do sprite.
    sprites = {
      MovementState.idle: santaIdle,
      MovementState.slideLeft: santaLeftSlide,
      MovementState.slideRight: santaRightSlide,
    };

    _rightBound = gameRef.size.x - 45;
    _leftBound = 45;
    _upBound = 45;
    _downBound = gameRef.size.y - 85;

    current = MovementState.idle;

    position = gameRef.size / 2;
    height = _spriteHeight;
    width = _spriteHeight * 1.42;
    anchor = Anchor.center;
  }

  @override
  void update(dt) {
    super.update(dt);

    // Se o joystick estiver parado, defina o estado como parado.
    if (joystick.direction == JoystickDirection.idle) {
      current = MovementState.idle;
      return;
    }

    //vai para esquerda
    if (x >= _rightBound) {
      x = x - 1;
    }
    //vai para direita
    if (x <= _leftBound) {
      x = x + 1;
    }
    //vai para cima
    if (y <= _upBound) {
      y = y + 1;
    }
    //vai para baixo
    if (y >= _downBound) {
      y = y - 1;
    }
    // Determina se o componente está se movendo para a esquerda no momento.
    bool movingLeft = joystick.relativeDelta[0] < 0;

    // Se mover para a esquerda, defina o estado como slideLeft.
    if (movingLeft) {
      current = MovementState.slideLeft;
    }
    // Caso contrário, defina o estado para slideRight.
    else {
      current = MovementState.slideRight;
    }

    // Update position.
    position.add(joystick.relativeDelta * _speed * dt);
  }
}
