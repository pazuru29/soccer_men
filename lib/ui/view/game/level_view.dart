import 'package:app_android_b_0245_24/logic/app_navigator.dart';
import 'package:app_android_b_0245_24/ui/view/game/controller/game_controller.dart';
import 'package:app_android_b_0245_24/ui/view/game/managers/ball_manager.dart';
import 'package:app_android_b_0245_24/ui/view/game/game_view.dart';
import 'package:app_android_b_0245_24/ui/view/game/managers/banana_manager.dart';
import 'package:app_android_b_0245_24/ui/view/game/result_view.dart';
import 'package:app_android_b_0245_24/ui/view/game/sprites/background.dart';
import 'package:app_android_b_0245_24/ui/view/game/sprites/ball.dart';
import 'package:app_android_b_0245_24/ui/view/game/sprites/banana.dart';
import 'package:app_android_b_0245_24/ui/view/game/sprites/player.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/cupertino.dart';

class LevelView extends Component with TapCallbacks, HasGameRef<Game> {
  LevelView();

  late Background _background;
  late Player _player;

  late BananaManager _bananaManager;
  late BallManager _ballManager;

  double _velocityScale = 1;

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onLoad() {
    startGame();
    super.onMount();
  }

  @override
  void update(double dt) {
    _gameVelocityScaleUpdate(dt);
    super.update(dt);
  }

  void startGame() async {
    _velocityScale = 1;

    _velocityScale += GameController.roundModel.roundNumber / 18;

    debugPrint('$_velocityScale');

    GameController.currentCoin.value = 0;
    GameController.currentLife.value = 4;

    _background = Background();

    _player = Player(
      Vector2(43, gameRef.size.y - 201),
      onTakeCoin: () {
        GameController.currentCoin.value += 1;

        if (GameController.currentCoin.value ==
            GameController.roundModel.needPoints) {
          gameRef.pauseEngine();
          AppNavigator.replaceToNextScreen(
              gameRef.buildContext!, const ResultView());
        }
        debugPrint('TAKE BALL | SCORE: ${GameController.currentCoin.value}');
      },
    );

    _ballManager = BallManager(
      gameRef.size,
      velocityScale: _velocityScale,
      timerScale: GameController.roundModel.ballTimerScale,
    );
    _bananaManager = BananaManager(
      gameRef.size,
      velocityScale: _velocityScale,
      timerScale: GameController.roundModel.bananaTimerScale,
    );
    addAll([
      _background,
      _player,
    ]);
    Future.delayed(const Duration(milliseconds: 3000), () {
      addAll([
        _ballManager,
        _bananaManager,
      ]);
    });
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!gameRef.paused && _player.position.y == gameRef.size.y - 201) {
      _player.jump();
    }
    super.onTapDown(event);
  }

  void _gameVelocityScaleUpdate(double dt) {
    if (_velocityScale < 2) {
      _velocityScale += 0.0002 * dt;
      debugPrint('$_velocityScale');
      _bananaManager.velocityScale = _velocityScale;
      for (final banana in _bananaManager.children.whereType<Banana>()) {
        banana.velocityScale = _velocityScale;
      }
      _ballManager.velocityScale = _velocityScale;
      for (final ball in _ballManager.children.whereType<Ball>()) {
        ball.velocityScale = _velocityScale;
      }
    }
  }
}
