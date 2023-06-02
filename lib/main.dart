import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:meuprimeirogame/games/gift_grab_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GameWidget(game: GiftGrabGame()));
}
