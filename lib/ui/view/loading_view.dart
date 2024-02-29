import 'package:app_android_b_0245_24/logic/app_navigator.dart';
import 'package:app_android_b_0245_24/logic/settings_controller.dart';
import 'package:app_android_b_0245_24/ui/components/base_screen.dart';
import 'package:app_android_b_0245_24/ui/view/home_view.dart';
import 'package:app_android_b_0245_24/ui/view/onboarding_view.dart';
import 'package:app_android_b_0245_24/utils/app_animations.dart';
import 'package:app_android_b_0245_24/utils/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingView extends BaseScreen {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends BaseScreenState<LoadingView> {
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 3000),
      () {
        if (SettingsController.shared.isFirstRun.value) {
          AppNavigator.replaceToNextScreen(context, const OnboardingView());
        } else {
          AppNavigator.replaceToNextScreen(context, const HomeView());
        }
      },
    );
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
          child: Lottie.asset(
            AppAnimations.loading,
            width: 150,
            height: 150,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
