import 'package:app_android_b_0245_24/logic/settings_controller.dart';
import 'package:app_android_b_0245_24/ui/components/base_screen.dart';
import 'package:app_android_b_0245_24/ui/components/secondary_app_bar.dart';
import 'package:app_android_b_0245_24/utils/app_colors.dart';
import 'package:app_android_b_0245_24/utils/app_icons.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class EditProfileView extends BaseScreen {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends BaseScreenState<EditProfileView> {
  Uint8List? _image;

  late final TextEditingController _nameController;
  late final FocusNode _nameFocus;

  @override
  void initState() {
    _nameController = TextEditingController();
    _nameFocus = FocusNode();

    _nameController.text = SettingsController.shared.userModel.value.name;
    _image = SettingsController.shared.userModel.value.image;
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      color: AppColors.backgroundMain,
      child: Column(
        children: [
          const SecondaryAppBar(title: ''),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _imageWidget(),
                  const Gap(24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 156),
                    child: TextField(
                      controller: _nameController,
                      focusNode: _nameFocus,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(60),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        labelText: 'Name',
                        helperText: 'Enter your name',
                        helperStyle: const TextStyle()
                            .copyWith(color: AppColors.textSecondary),
                        labelStyle: const TextStyle()
                            .copyWith(color: AppColors.textSecondary),
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                      onSubmitted: (text) {
                        setState(() {
                          _saveName();
                        });
                      },
                      onTapOutside: (detail) {
                        setState(() {
                          _nameFocus.unfocus();
                          _saveName();
                        });
                      },
                    ),
                  ),
                  Gap(MediaQuery.paddingOf(context).bottom + 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageWidget() {
    return GestureDetector(
      onTap: () async {
        try {
          await SettingsController.shared.getPhoto().then((value) {
            if (value != null) {
              setState(() {
                _image = value;
                SettingsController.shared.saveUserPhoto(value);
              });
            }
          });
        } catch (e) {
          AppSettings.openAppSettings(type: AppSettingsType.security);
        }
      },
      child: Container(
        height: 159,
        color: Colors.transparent,
        child: Stack(
          children: [
            if (_image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.memory(
                  _image!,
                  height: 124,
                  width: 124,
                  fit: BoxFit.cover,
                ),
              ),
            if (_image == null)
              SvgPicture.asset(
                AppIcons.avatar,
                height: 124,
                width: 124,
              ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SvgPicture.asset(
                AppIcons.add,
                height: 48,
                width: 48,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedName() {
    return _nameController.text.trimLeft().trimRight();
  }

  void _saveName() {
    if (_getFormattedName().isEmpty) {
      _nameController.text = SettingsController.shared.userModel.value.name;
    } else {
      SettingsController.shared.saveUserName(_getFormattedName());
    }
  }
}
