import 'dart:async';
import 'dart:math' as math;

import 'package:app_android_b_0245_24/ui/view/game/sprites/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Ball extends SpriteComponent with CollisionCallbacks {
  double velocityScale;

  Ball(
    Vector2 position, {
    required this.velocityScale,
  }) : super(
          size: Vector2(64, 64),
          position: position,
          anchor: Anchor.center,
        );

  static const speed = 0.3;
  double speedX = 250;
  double xMax = 0;
  double yMax = 0;
  double spacingFromBorder = 0;

  @override
  FutureOr<void> onLoad() async {
    String assetName = 'ball_1.png';

    switch (math.Random().nextInt(5) + 1) {
      case 1:
        assetName = 'ball_1.png';
      case 2:
        assetName = 'ball_2.png';
      case 3:
        assetName = 'ball_3.png';
      case 4:
        assetName = 'ball_4.png';
      case 5:
        assetName = 'ball_5.png';
    }

    sprite = await Sprite.load(assetName);

    // final hitboxPaint = BasicPalette.white.paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 2;

    add(CircleHitbox(
      position: Vector2(32, 32),
      radius: height / 2,
      anchor: Anchor.center,
      isSolid: true,
    )
        // ..paint = hitboxPaint
        // ..renderShape = true,
        );
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);
    angle += speed * dt;
    angle %= 2 * math.pi;
    position.x -= (speedX * velocityScale) * dt;
    if (position.x < ((size.x / 2) * (-1))) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}
