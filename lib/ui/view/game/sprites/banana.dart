import 'dart:async';

import 'package:app_android_b_0245_24/ui/view/game/controller/game_controller.dart';
import 'package:app_android_b_0245_24/ui/view/game/sprites/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Banana extends SpriteComponent with CollisionCallbacks {
  double velocityScale;

  Banana(
    Vector2 position, {
    required this.velocityScale,
  }) : super(
          size: Vector2(111, 61),
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
    // final hitboxPaint = BasicPalette.white.paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 2;

    sprite = await Sprite.load('banana.png');

    add(PolygonHitbox(
      [
        Vector2(width, height), // right
        Vector2(0, height), // left
        Vector2(width / 3, 0), // top
      ],
      isSolid: true,
    )
        // ..paint = hitboxPaint
        // ..renderShape = true,
        );
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);
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
