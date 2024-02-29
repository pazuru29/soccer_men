import 'package:app_android_b_0245_24/logic/app_navigator.dart';
import 'package:app_android_b_0245_24/logic/settings_controller.dart';
import 'package:app_android_b_0245_24/ui/components/app_icon_button.dart';
import 'package:app_android_b_0245_24/ui/components/base_screen.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text_style.dart';
import 'package:app_android_b_0245_24/ui/view/game/controller/game_controller.dart';
import 'package:app_android_b_0245_24/ui/view/game/game_view.dart';
import 'package:app_android_b_0245_24/ui/view/settings_view.dart';
import 'package:app_android_b_0245_24/utils/app_colors.dart';
import 'package:app_android_b_0245_24/utils/app_icons.dart';
import 'package:app_android_b_0245_24/utils/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ResultView extends BaseScreen {
  const ResultView({super.key});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends BaseScreenState<ResultView> {
  late bool _isWin;

  @override
  void initState() {
    _isWin = GameController.currentCoin.value ==
            GameController.roundModel.needPoints &&
        GameController.currentLife.value > 0;

    if (_isWin) {
      SettingsController.shared.addNewStars(
          GameController.roundModel.roundNumber,
          GameController.currentLife.value == 4
              ? 3
              : GameController.currentLife.value >= 2
                  ? 2
                  : 1);
    }
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _stars(),
              const Gap(6),
              _main(),
              const Gap(13),
              _buttons(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _stars() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          _isWin && GameController.currentLife.value >= 1
              ? AppIcons.star
              : AppIcons.starGrey,
          width: 40,
          height: 40,
        ),
        const Gap(5),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SvgPicture.asset(
            _isWin && GameController.currentLife.value >= 2
                ? AppIcons.star
                : AppIcons.starGrey,
            width: 40,
            height: 40,
          ),
        ),
        const Gap(5),
        SvgPicture.asset(
          _isWin && GameController.currentLife.value == 4
              ? AppIcons.star
              : AppIcons.starGrey,
          width: 40,
          height: 40,
        ),
      ],
    );
  }

  Widget _buttons() {
    return Row(
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
            AppNavigator.replaceToNextScreen(context, const SettingsView());
          },
        ),
        const Gap(16),
        AppIconButton(
          assetName: AppIcons.reset,
          onPressed: () {
            AppNavigator.replaceToNextScreen(
                context, GameView(roundModel: GameController.roundModel));
          },
        ),
      ],
    );
  }

  Widget _main() {
    return Stack(
      children: [
        Container(
          width: 257,
          height: 127,
          margin: const EdgeInsets.only(top: 13),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.layer2,
            border: Border.all(color: AppColors.layer1, width: 2.4),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.layer3,
              border: Border.all(color: AppColors.layer1, width: 2.4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: AppText(
                text: _isWin
                    ? 'Congratulations, you\nhave passed the level'
                    : 'You lost,\ntry again!',
                style: AppTextStyles.semibold18,
                color: AppColors.textWhite,
                align: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          child: SvgPicture.asset(AppIcons.result),
        ),
        const Positioned(
          right: 0,
          left: 0,
          top: 4,
          child: AppText(
            text: 'Result',
            style: AppTextStyles.semibold18,
            color: AppColors.textWhite,
            align: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
