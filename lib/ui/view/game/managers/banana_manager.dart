import 'dart:math';

import 'package:app_android_b_0245_24/ui/view/game/sprites/banana.dart';
import 'package:flame/components.dart';

class BananaManager extends Component {
  double velocityScale;
  Vector2 gameSize;
  late Timer _timer;
  Random random = Random();

  BananaManager(
    this.gameSize, {
    required this.velocityScale,
    required double timerScale,
  }) : super() {
    _timer = Timer(3.5 / timerScale, onTick: _mainSpawn, repeat: true);
  }

  void _mainSpawn() {
    _spawnBanana();
  }

  void _spawnBanana() {
    var positionY = (gameSize.y - 114);

    final position = Vector2(
      gameSize.x + 32,
      positionY,
    );
    final banana = Banana(
      position,
      velocityScale: velocityScale,
    );

    add(banana);
  }

  @override
  void onMount() {
    _timer.start();
    super.onMount();
  }

  @override
  void onRemove() {
    _timer.stop();
    super.onRemove();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }
}
