import 'package:app_android_b_0245_24/logic/models/round_model.dart';
import 'package:app_android_b_0245_24/logic/settings_controller.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text_style.dart';
import 'package:app_android_b_0245_24/utils/app_colors.dart';
import 'package:app_android_b_0245_24/utils/app_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class RoundWidget extends StatefulWidget {
  final RoundModel round;
  final VoidCallback? onPressed;

  const RoundWidget({
    super.key,
    required this.round,
    this.onPressed,
  });

  @override
  State<RoundWidget> createState() => _RoundWidgetState();
}

class _RoundWidgetState extends State<RoundWidget> {
  bool _isHighlighted = false;

  set isHighlighted(bool value) {
    setState(() {
      if (widget.onPressed != null) {
        _isHighlighted = value;
      }
    });
  }

  Color _getBgColor() {
    Color color = AppColors.layer2;
    if (widget.onPressed == null || _isHighlighted) {
      color = AppColors.layer3;
    }

    return color;
  }

  Color _getBorderColor() {
    Color color = AppColors.layer1;
    if (widget.onPressed == null || _isHighlighted) {
      color = AppColors.layer2;
    }

    return color;
  }

  Color _getTextColor() {
    Color color = AppColors.textWhite;
    if (widget.onPressed == null || _isHighlighted) {
      color = AppColors.textWhite.withOpacity(0.7);
    }

    return color;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (details) {
        isHighlighted = true;
      },
      onTapUp: (details) {
        isHighlighted = false;
      },
      onTapCancel: () {
        isHighlighted = false;
      },
      child: Container(
        width: 85,
        height: 102,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.fromLTRB(14, 6, 14, 14),
        decoration: BoxDecoration(
          color: _getBgColor(),
          border: Border.all(color: _getBorderColor(), width: 2.4),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _stars(),
            const Gap(5),
            Container(
              width: 57,
              height: 51,
              decoration: BoxDecoration(
                color: AppColors.layer3,
                border: Border.all(color: _getBorderColor(), width: 2.4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: AppText(
                  text: widget.round.roundNumber.toString(),
                  style: AppTextStyles.semibold30,
                  color: _getTextColor(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stars() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          SettingsController.shared.starsPerRound
                          .value[widget.round.roundNumber] !=
                      null &&
                  SettingsController.shared.starsPerRound
                          .value[widget.round.roundNumber]! >=
                      1
              ? AppIcons.star
              : AppIcons.starGrey,
          width: 16,
          height: 17,
        ),
        const Gap(1.4),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: SvgPicture.asset(
            SettingsController.shared.starsPerRound
                            .value[widget.round.roundNumber] !=
                        null &&
                    SettingsController.shared.starsPerRound
                            .value[widget.round.roundNumber]! >=
                        2
                ? AppIcons.star
                : AppIcons.starGrey,
            width: 16,
            height: 17,
          ),
        ),
        const Gap(1.4),
        SvgPicture.asset(
          SettingsController.shared.starsPerRound
                          .value[widget.round.roundNumber] !=
                      null &&
                  SettingsController.shared.starsPerRound
                          .value[widget.round.roundNumber]! >=
                      3
              ? AppIcons.star
              : AppIcons.starGrey,
          width: 16,
          height: 17,
        ),
      ],
    );
  }
}
