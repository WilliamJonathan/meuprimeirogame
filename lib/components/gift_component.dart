import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:meuprimeirogame/components/santa_component.dart';
import '../constants/globals.dart';
import '../games/gift_grab_game.dart';

class GiftComponent extends SpriteComponent
    with HasGameRef<GiftGrabGame>, CollisionCallbacks {
  final double _spriteHeight = 100;

  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.giftSprite);
    height = width = _spriteHeight;
    position = _getRandomPosition();
    anchor = Anchor.center;

    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is SantaComponent) {
      // Reproduzir som de captura de presente.
      FlameAudio.play(Globals.itemGrabSound);
      // Remova o presente que acabou de colidir.
      removeFromParent();
      // Atualize a pontuação do Papai Noel em um.
      gameRef.score += 1;
      // Adiciona um novo presente ao campo.
      gameRef.add(GiftComponent());
    }
  }

  Vector2 _getRandomPosition() {
    double x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
    double y = _random.nextInt(gameRef.size.y.toInt()).toDouble();
    return Vector2(x, y);
  }
}
