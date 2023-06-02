import 'package:flame/components.dart';
import '../constants/globals.dart';
import '../games/gift_grab_game.dart';

class IceComponent extends SpriteComponent with HasGameRef<GiftGrabGame> {
  final double _spriteHeight = 100;
  final Vector2 startPosition;

  IceComponent({required this.startPosition});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.iceSprite);
    position = startPosition;
    height = width = _spriteHeight;
    anchor = Anchor.center;
  }
}
