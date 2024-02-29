import 'package:app_android_b_0245_24/ui/components/text/app_text.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text_style.dart';
import 'package:app_android_b_0245_24/ui/view/game/controller/game_controller.dart';
import 'package:app_android_b_0245_24/ui/view/game/game_view.dart';
import 'package:app_android_b_0245_24/utils/app_colors.dart';
import 'package:app_android_b_0245_24/utils/app_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class StartOverlay extends StatefulWidget {
  final Game gameRef;

  const StartOverlay({
    super.key,
    required this.gameRef,
  });

  @override
  State<StartOverlay> createState() => _StartOverlayState();
}

class _StartOverlayState extends State<StartOverlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.layer3.withOpacity(0.6),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                SvgPicture.asset(AppIcons.pauseBg),
                const Positioned(
                  top: 8,
                  right: 0,
                  left: 0,
                  child: AppText(
                    text: 'The game begins!',
                    style: AppTextStyles.regular16,
                    color: Colors.black,
                    align: TextAlign.center,
                  ),
                ),
                Positioned(
                  bottom: 32,
                  right: 0,
                  left: 0,
                  child: AppText(
                    text:
                        'Collect ${GameController.roundModel.needPoints} coins to pass the level',
                    style: AppTextStyles.semibold18,
                    color: AppColors.textWhite,
                    align: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
