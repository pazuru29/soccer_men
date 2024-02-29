import 'package:app_android_b_0245_24/ui/view/game/game_view.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Background extends SpriteComponent with HasGameRef<Game> {
  Background();

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load("game_background.png");
    size = gameRef.size;
    sprite = Sprite(background);
  }
}
