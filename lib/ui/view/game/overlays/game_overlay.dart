import 'package:app_android_b_0245_24/ui/components/app_round_icon_button.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text_style.dart';
import 'package:app_android_b_0245_24/ui/view/game/controller/game_controller.dart';
import 'package:app_android_b_0245_24/utils/app_colors.dart';
import 'package:app_android_b_0245_24/utils/app_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class GameOverlay extends StatefulWidget {
  final VoidCallback onPausePressed;

  const GameOverlay({
    super.key,
    required this.onPausePressed,
  });

  @override
  State<GameOverlay> createState() => _GameOverlayState();
}

class _GameOverlayState extends State<GameOverlay> {
  @override
  void initState() {
    GameController.currentCoin.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    GameController.currentLife.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 11, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _coin(),
              const Gap(9),
              _life(),
            ],
          ),
          AppRoundIconButton(
            assetName: AppIcons.pause,
            onPressed: widget.onPausePressed,
          ),
        ],
      ),
    );
  }

  Widget _coin() {
    return Stack(
      children: [
        Container(
          width: 103,
          height: 34,
          margin: const EdgeInsets.fromLTRB(19, 6, 0, 4),
          padding: const EdgeInsets.fromLTRB(27, 4, 4, 4),
          decoration: BoxDecoration(
            color: AppColors.layer2,
            border: Border.all(color: AppColors.layer1, width: 2.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.layer3,
              border: Border.all(color: AppColors.layer1, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: AppText(
                text: '${GameController.currentCoin.value}',
                style: AppTextStyles.semibold18,
                color: AppColors.textWhite,
                align: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ),
        ),
        SvgPicture.asset(AppIcons.coin),
      ],
    );
  }

  Widget _life() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.layer2,
        border: Border.all(color: AppColors.layer1, width: 1.78),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            GameController.currentLife.value >= 1
                ? AppIcons.life
                : AppIcons.lifeLost,
          ),
          const Gap(7),
          SvgPicture.asset(
            GameController.currentLife.value >= 2
                ? AppIcons.life
                : AppIcons.lifeLost,
          ),
          const Gap(7),
          SvgPicture.asset(
            GameController.currentLife.value >= 3
                ? AppIcons.life
                : AppIcons.lifeLost,
          ),
          const Gap(7),
          SvgPicture.asset(
            GameController.currentLife.value >= 4
                ? AppIcons.life
                : AppIcons.lifeLost,
          ),
        ],
      ),
    );
  }
}
