import 'package:app_android_b_0245_24/logic/app_navigator.dart';
import 'package:app_android_b_0245_24/logic/settings_controller.dart';
import 'package:app_android_b_0245_24/ui/components/app_button.dart';
import 'package:app_android_b_0245_24/ui/components/app_icon_button.dart';
import 'package:app_android_b_0245_24/ui/components/base_screen.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text_style.dart';
import 'package:app_android_b_0245_24/ui/view/rounds_view.dart';
import 'package:app_android_b_0245_24/ui/view/settings_view.dart';
import 'package:app_android_b_0245_24/utils/app_colors.dart';
import 'package:app_android_b_0245_24/utils/app_icons.dart';
import 'package:app_android_b_0245_24/utils/app_images.dart';
import 'package:app_android_b_0245_24/utils/app_music.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeView extends BaseScreen {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseScreenState<HomeView> {
  @override
  void initState() {
    if (SettingsController.shared.isNeedMusic.value) {
      FlameAudio.bgm.play(AppMusic.bgMusic);
    }

    SettingsController.shared.isNeedMusic.addListener(() {
      if (mounted) {
        setState(() {
          debugPrint('HOME VIEW | NOTIFY CHANGE MUSIC HOME VIEW');
        });
      }
    });

    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppImages.preloader,
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.fromLTRB(64, 21, 64, 21),
            margin: const EdgeInsets.only(top: 41),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText(
                  text: 'Hello!\nDo you want to start\nthe game?',
                  style: AppTextStyles.headerLarge,
                  color: AppColors.textBlack,
                  maxLines: null,
                  align: TextAlign.center,
                ),
                const Gap(11),
                AppButton(
                  text: 'The game begins!',
                  onPressed: () {
                    AppNavigator.goToNextScreen(context, const RoundsView());
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                  setState(() {
                    SettingsController.shared.changeNeedMusic(
                        !SettingsController.shared.isNeedMusic.value);
                  });
                },
              ),
              const Gap(20),
              AppIconButton(
                assetName: AppIcons.settings,
                onPressed: () {
                  AppNavigator.goToNextScreen(context, const SettingsView());
                },
              ),
              const Gap(16),
            ],
          ),
        ),
      ],
    );
  }
}
