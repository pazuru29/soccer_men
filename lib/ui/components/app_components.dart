import 'package:app_android_b_0245_24/logic/app_navigator.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text_style.dart';
import 'package:app_android_b_0245_24/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppComponents {
  static void showDeleteDialog(
      BuildContext context, VoidCallback onDeletePressed) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          child: Container(
            width: 312,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText(
                  text: 'Delete progress',
                  style: AppTextStyles.headerSmall,
                  color: AppColors.textBlack,
                  maxLines: null,
                  align: TextAlign.center,
                ),
                const Gap(9),
                const AppText(
                  text: 'Are you sure? All your progress\nwill be discarded.',
                  style: AppTextStyles.regular14,
                  color: AppColors.textBlack,
                  maxLines: null,
                  align: TextAlign.center,
                ),
                const Gap(26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        AppNavigator.goBack(context);
                        onDeletePressed();
                      },
                      child: const AppText(
                        text: 'Delete',
                        style: AppTextStyles.semibold14,
                        color: AppColors.textBlack,
                      ),
                    ),
                    const Gap(24),
                    TextButton(
                      onPressed: () {
                        AppNavigator.goBack(context);
                      },
                      child: const AppText(
                        text: 'Cancel',
                        style: AppTextStyles.semibold14,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
