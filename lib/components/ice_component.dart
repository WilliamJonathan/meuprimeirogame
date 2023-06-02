import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../constants/globals.dart';
import '../games/gift_grab_game.dart';
import 'dart:math' as math;

class IceComponent extends SpriteComponent
    with HasGameRef<GiftGrabGame>, CollisionCallbacks {
  final double _spriteHeight = 100;

  late Vector2 _velocity;
  double speed = 150;

  /// Ângulo ou o presente na recuperação.
  double degree = math.pi / 180;
  final Vector2 startPosition;

  IceComponent({required this.startPosition});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.iceSprite);
    position = startPosition;
    width = _spriteHeight;
    height = _spriteHeight;
    anchor = Anchor.center;

    final double spawnAngle = _getSpawnAngle();

    final double vx = math.cos(spawnAngle * degree) * speed;
    final double vy = math.sin(spawnAngle * degree) * speed;

    _velocity = Vector2(vx, vy);

    add(CircleHitbox());
    //add(CircleHitbox()..radius = 1);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      final Vector2 collisionPoint = intersectionPoints.first;

      // Colisão do Lado Esquerdo
      if (collisionPoint.x <= 0) {
        _velocity.x = -_velocity.x;
      }
      // Colisão do lado direito
      if (collisionPoint.x >= gameRef.size.x) {
        _velocity.x = -_velocity.x;
        print('Numero x: ${gameRef.size.x}');
      }
      // Colisão Lateral Superior
      if (collisionPoint.y <= 0) {
        _velocity.y = -_velocity.y;
      }
      // Colisão Lateral Inferior
      if (collisionPoint.y >= gameRef.size.y) {
        _velocity.y = -_velocity.y;
        print('Numero y: ${gameRef.size.y}');
      }

      // //Colisão do Lado Esquerdo
      // if (collisionPoint.x <= 0) {
      //   _velocity.x = -_velocity.x;
      //   _velocity.y = _velocity.y;
      // }
      // // Colisão do lado direito
      // if (collisionPoint.x >= gameRef.size.x) {
      //   _velocity.x = -_velocity.x;
      //   _velocity.y = _velocity.y;
      // }
      // // Colisão Lateral Superior
      // if (collisionPoint.y <= 0) {
      //   _velocity.x = _velocity.x;
      //   _velocity.y = -_velocity.y;
      // }
      // // Colisão Lateral Inferior
      // if (collisionPoint.y >= gameRef.size.y) {
      //   _velocity.x = _velocity.x;
      //   _velocity.y = -_velocity.y;
      // }
    }
  }

  double _getSpawnAngle() {
    final random = math.Random().nextDouble();
    final spawnAngle = lerpDouble(0, 360, random)!;
    return spawnAngle;
  }
}
