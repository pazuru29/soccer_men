import 'package:app_android_b_0245_24/logic/models/round_model.dart';
import 'package:app_android_b_0245_24/ui/components/base_screen.dart';
import 'package:app_android_b_0245_24/ui/view/game/controller/game_controller.dart';
import 'package:app_android_b_0245_24/ui/view/game/level_view.dart';
import 'package:app_android_b_0245_24/ui/view/game/overlays/game_overlay.dart';
import 'package:app_android_b_0245_24/ui/view/game/overlays/pause_overlay.dart';
import 'package:app_android_b_0245_24/ui/view/game/overlays/start_overlay.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flame/src/components/route.dart' as route;

class GameView extends BaseScreen {
  final RoundModel roundModel;

  const GameView({
    super.key,
    required this.roundModel,
  });

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends BaseScreenState<GameView>
    with WidgetsBindingObserver {
  late final RouterComponent router;
  late final Game game;

  bool _isPaused = false;

  bool _startOverlayShowed = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      setState(() {
        _isPaused = true;
        game.pauseEngine();
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    GameController.roundModel = widget.roundModel;

    router = RouterComponent(
      routes: {
        'levelView': route.Route(LevelView.new),
      },
      initialRoute: 'levelView',
    );
    game = Game(router: router);

    Future.delayed(const Duration(milliseconds: 4000), () {
      setState(() {
        _startOverlayShowed = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget buildMain(BuildContext context) {
    return Stack(
      children: [
        GameWidget(
          game: game,
        ),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: GameOverlay(
            onPausePressed: () {
              setState(() {
                game.pauseEngine();
                _isPaused = true;
              });
            },
          ),
        ),
        if (_isPaused)
          PauseOverlay(
            gameRef: game,
            onPlayPressed: () {
              setState(() {
                game.resumeEngine();
                _isPaused = false;
              });
            },
          ),
        if (_startOverlayShowed && !_isPaused) StartOverlay(gameRef: game),
      ],
    );
  }
}

class Game extends FlameGame with HasCollisionDetection {
  final RouterComponent router;

  Game({required this.router});

  @override
  Future<void> onLoad() async {
    add(router);
  }
}
