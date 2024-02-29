import 'package:app_android_b_0245_24/logic/app_navigator.dart';
import 'package:app_android_b_0245_24/logic/settings_controller.dart';
import 'package:app_android_b_0245_24/ui/components/app_button.dart';
import 'package:app_android_b_0245_24/ui/components/base_screen.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text_style.dart';
import 'package:app_android_b_0245_24/ui/view/home_view.dart';
import 'package:app_android_b_0245_24/utils/app_colors.dart';
import 'package:app_android_b_0245_24/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OnboardingView extends BaseScreen {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends BaseScreenState<OnboardingView> {
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
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 21),
                margin: const EdgeInsets.only(top: 41),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Gap(84),
                    const AppText(
                      text: 'Start your first game right now!',
                      style: AppTextStyles.headerMedium,
                      color: AppColors.textBlack,
                    ),
                    const Gap(11),
                    AppButton(
                      text: 'Start',
                      onPressed: () {
                        SettingsController.shared.changeFirstRun(false);
                        AppNavigator.replaceToNextScreen(
                            context, const HomeView());
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Image.asset(
                  AppImages.ball2,
                  width: 103,
                  height: 103,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
