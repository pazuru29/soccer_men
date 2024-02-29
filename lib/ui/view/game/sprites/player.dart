import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:app_android_b_0245_24/logic/app_navigator.dart';
import 'package:app_android_b_0245_24/ui/view/game/controller/game_controller.dart';
import 'package:app_android_b_0245_24/ui/view/game/game_view.dart';
import 'package:app_android_b_0245_24/ui/view/game/result_view.dart';
import 'package:app_android_b_0245_24/ui/view/game/sprites/ball.dart';
import 'package:app_android_b_0245_24/ui/view/game/sprites/banana.dart';
import 'package:app_android_b_0245_24/utils/constants.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<Game> {
  Vector2 startPosition;
  VoidCallback onTakeCoin;

  Player(
    this.startPosition, {
    required this.onTakeCoin,
  }) : super(
          size: Vector2(90, 117),
          position: startPosition,
        );

  static const speed = 0.3;
  double speedY = 0;

  late ui.Image _runManSpriteSheet;
  late ui.Image _jumpManSpriteSheet;

  @override
  FutureOr<void> onLoad() async {
    _runManSpriteSheet = await Flame.images.load('player_spritesheet.png');
    _jumpManSpriteSheet = await Flame.images.load('jump_player.png');

    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 8, stepTime: 0.08, textureSize: Vector2(180, 232));

    animation = SpriteAnimation.fromFrameData(_runManSpriteSheet, spriteData);

    // final hitboxPaint = BasicPalette.white.paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 2;

    add(PolygonHitbox(
      [
        Vector2(width - 10, height - 10), // right
        Vector2(20, height - 10), // left
        Vector2(width / 2, 0), // top
        Vector2(width - 10, 20), // top
      ],
      isSolid: true,
    )
        // ..paint = hitboxPaint
        // ..renderShape = true,
        );
  }

  @override
  Future<void> update(double dt) async {
    speedY += gravity * dt;
    y += speedY * dt;

    y = min(y, startPosition.y);
    super.update(dt);
  }

  Future<void> jump() async {
    debugPrint("JUMP");
    speedY = 0;
    speedY -= jumpPower;

    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 1, stepTime: 1, textureSize: Vector2(180, 232));

    animation = SpriteAnimation.fromFrameData(_jumpManSpriteSheet, spriteData);

    Future.delayed(const Duration(milliseconds: 900), () async {
      SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
          amount: 8, stepTime: 0.08, textureSize: Vector2(180, 232));

      animation = SpriteAnimation.fromFrameData(_runManSpriteSheet, spriteData);
    });
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Banana) {
      debugPrint('LIFE: ${GameController.currentLife.value}');
      if (GameController.currentLife.value > 1) {
        GameController.currentLife.value--;
      } else {
        GameController.currentLife.value--;
        gameRef.pauseEngine();
        AppNavigator.replaceToNextScreen(
            gameRef.buildContext!, const ResultView());
      }
    }
    if (other is Ball) {
      onTakeCoin();
    }
    super.onCollision(intersectionPoints, other);
  }
}
