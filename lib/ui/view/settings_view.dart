import 'package:app_android_b_0245_24/logic/app_navigator.dart';
import 'package:app_android_b_0245_24/logic/settings_controller.dart';
import 'package:app_android_b_0245_24/ui/components/app_back_button.dart';
import 'package:app_android_b_0245_24/ui/components/app_button.dart';
import 'package:app_android_b_0245_24/ui/components/app_components.dart';
import 'package:app_android_b_0245_24/ui/components/base_screen.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text_style.dart';
import 'package:app_android_b_0245_24/ui/view/edit_profile_view.dart';
import 'package:app_android_b_0245_24/ui/view/onboarding_view.dart';
import 'package:app_android_b_0245_24/ui/view/privacy_view.dart';
import 'package:app_android_b_0245_24/ui/view/rules_view.dart';
import 'package:app_android_b_0245_24/utils/app_colors.dart';
import 'package:app_android_b_0245_24/utils/app_icons.dart';
import 'package:app_android_b_0245_24/utils/app_images.dart';
import 'package:app_android_b_0245_24/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';

class SettingsView extends BaseScreen {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends BaseScreenState<SettingsView> {
  @override
  void initState() {
    SettingsController.shared.userModel.addListener(() {
      if (mounted) {
        setState(() {
          debugPrint('SETTINGS VIEW | NOTIFY CHANGE USER MODEL');
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppText(
                text: 'Settings',
                style: AppTextStyles.headerSmall,
                color: AppColors.textWhite,
              ),
              const Gap(13),
              Container(
                padding: const EdgeInsets.fromLTRB(45, 15, 18, 19),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(child: _profile()),
                    const Gap(66),
                    _settings(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 13,
          left: 16,
          child: AppBackButton(
            onPressed: () {
              AppNavigator.goBack(context);
            },
          ),
        ),
      ],
    );
  }

  Widget _profile() {
    return GestureDetector(
      onTap: () {
        AppNavigator.goToNextScreen(context, const EditProfileView());
      },
      child: Container(
        color: Colors.transparent,
        constraints: const BoxConstraints(maxWidth: 124),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 152,
              child: Stack(
                children: [
                  if (SettingsController.shared.userModel.value.image != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.memory(
                        SettingsController.shared.userModel.value.image!,
                        width: 124,
                        height: 124,
                        fit: BoxFit.cover,
                      ),
                    ),
                  if (SettingsController.shared.userModel.value.image == null)
                    SvgPicture.asset(
                      AppIcons.avatar,
                      width: 124,
                      height: 124,
                    ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: SvgPicture.asset(
                      AppIcons.edit,
                      width: 48,
                      height: 48,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(11),
            Flexible(
              child: AppText(
                text: SettingsController.shared.userModel.value.name,
                style: AppTextStyles.regular20,
                color: AppColors.textBlack,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settings() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton(
          text: 'Privacy Policy',
          onPressed: () {
            AppNavigator.goToNextScreen(context, const PrivacyView());
          },
        ),
        const Gap(8),
        AppButton(
          text: 'Game rules',
          onPressed: () {
            AppNavigator.goToNextScreen(context, const RulesView());
          },
        ),
        const Gap(8),
        AppButton(
          text: 'Delete progress',
          onPressed: () {
            AppComponents.showDeleteDialog(
              context,
              () async {
                await Hive.openBox(kAppStorage).then((value) {
                  value.clear();
                  debugPrint('DATA CLEAR');

                  debugPrint('SET INIT DATA');
                  SettingsController.shared.setInitData();

                  AppNavigator.replaceAllScreens(
                      context, const OnboardingView());
                });
              },
            );
          },
        ),
      ],
    );
  }
}
