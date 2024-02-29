import 'dart:math';

import 'package:app_android_b_0245_24/ui/view/game/sprites/ball.dart';
import 'package:flame/components.dart';

class BallManager extends Component {
  double velocityScale;
  Vector2 gameSize;
  late Timer _timer;
  Random random = Random();

  BallManager(
    this.gameSize, {
    required this.velocityScale,
    required double timerScale,
  }) : super() {
    _timer = Timer(1.7 / timerScale, onTick: _mainSpawn, repeat: true);
  }

  void _mainSpawn() {
    _spawnBall();
  }

  void _spawnBall() {
    var positionY = (gameSize.y - 243);

    final position = Vector2(
      gameSize.x + 32,
      positionY,
    );
    final ball = Ball(
      position,
      velocityScale: velocityScale,
    );

    add(ball);
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
