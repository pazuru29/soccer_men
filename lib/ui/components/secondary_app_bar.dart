import 'package:app_android_b_0245_24/logic/app_navigator.dart';
import 'package:app_android_b_0245_24/ui/components/app_back_button.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text_style.dart';
import 'package:app_android_b_0245_24/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SecondaryAppBar extends StatelessWidget {
  final String title;

  const SecondaryAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.fromLTRB(16, 13, 16, 8),
      color: AppColors.backgroundMain,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppBackButton(
            onPressed: () {
              AppNavigator.goBack(context);
            },
          ),
          AppText(
            text: title,
            style: AppTextStyles.headerSmall,
            color: AppColors.textWhite,
          ),
          const Gap(53),
        ],
      ),
    );
  }
}
