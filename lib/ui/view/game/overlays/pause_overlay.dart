import 'package:app_android_b_0245_24/logic/app_navigator.dart';
import 'package:app_android_b_0245_24/logic/settings_controller.dart';
import 'package:app_android_b_0245_24/ui/components/app_icon_button.dart';
import 'package:app_android_b_0245_24/ui/components/app_round_icon_button.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text_style.dart';
import 'package:app_android_b_0245_24/ui/view/game/controller/game_controller.dart';
import 'package:app_android_b_0245_24/ui/view/game/game_view.dart';
import 'package:app_android_b_0245_24/ui/view/settings_view.dart';
import 'package:app_android_b_0245_24/utils/app_colors.dart';
import 'package:app_android_b_0245_24/utils/app_icons.dart';
import 'package:app_android_b_0245_24/utils/app_music.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class PauseOverlay extends StatefulWidget {
  final Game gameRef;
  final VoidCallback onPlayPressed;

  const PauseOverlay({
    super.key,
    required this.gameRef,
    required this.onPlayPressed,
  });

  @override
  State<PauseOverlay> createState() => _PauseOverlayState();
}

class _PauseOverlayState extends State<PauseOverlay> {
  @override
  void initState() {
    SettingsController.shared.isNeedMusic.addListener(() {
      if (mounted) {
        setState(() {
          debugPrint('NOTIFY CHANGE MUSIC');
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.layer3.withOpacity(0.6),
      body: Stack(
        children: [
          Positioned(
            top: 11,
            right: 16,
            child: AppRoundIconButton(
              assetName: AppIcons.play,
              onPressed: widget.onPlayPressed,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    SvgPicture.asset(AppIcons.pauseBg),
                    const Positioned(
                      bottom: 32,
                      right: 0,
                      left: 0,
                      child: AppText(
                        text: 'Pause',
                        style: AppTextStyles.semibold18,
                        color: AppColors.textWhite,
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIconButton(
                      assetName: AppIcons.home,
                      onPressed: () {
                        AppNavigator.goBack(context);
                      },
                    ),
                    const Gap(16),
                    AppIconButton(
                      assetName: AppIcons.settings,
                      onPressed: () {
                        AppNavigator.goToNextScreen(
                            context, const SettingsView());
                      },
                    ),
                    const Gap(16),
                    AppIconButton(
                      assetName: AppIcons.reset,
                      onPressed: () {
                        AppNavigator.replaceToNextScreen(context,
                            GameView(roundModel: GameController.roundModel));
                      },
                    ),
                    const Gap(16),
                    AppIconButton(
                      assetName: AppIcons.music,
                      isReversed: !SettingsController.shared.isNeedMusic.value,
                      onPressed: () {
                        if (!SettingsController.shared.isNeedMusic.value) {
                          if (FlameAudio.bgm.audioPlayer.state ==
                              PlayerState.paused) {
                            FlameAudio.bgm.resume();
                          } else {
                            FlameAudio.bgm.play(AppMusic.bgMusic);
                          }
                        } else {
                          FlameAudio.bgm.pause();
                        }
                        SettingsController.shared.changeNeedMusic(
                            !SettingsController.shared.isNeedMusic.value);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
