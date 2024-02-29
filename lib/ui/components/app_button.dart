import 'package:app_android_b_0245_24/ui/components/text/app_text.dart';
import 'package:app_android_b_0245_24/ui/components/text/app_text_style.dart';
import 'package:app_android_b_0245_24/utils/app_colors.dart';
import 'package:app_android_b_0245_24/utils/app_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isHighlighted = false;

  set isHighlighted(bool value) {
    setState(() {
      if (widget.onPressed != null) {
        _isHighlighted = value;
      }
    });
  }

  String _getBg() {
    String assetName = AppIcons.buttonBg;
    if (widget.onPressed == null || _isHighlighted) {
      assetName = AppIcons.buttonBgPressed;
    }

    return assetName;
  }

  Color _getTextColor() {
    Color color = AppColors.textWhite;
    if (widget.onPressed == null) {
      color = AppColors.textWhite.withOpacity(0.5);
    } else if (_isHighlighted) {
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
      child: Stack(
        children: [
          SvgPicture.asset(
            _getBg(),
            height: 60,
            width: 219,
          ),
          Positioned(
            top: 16,
            right: 10,
            left: 10,
            child: AppText(
              text: widget.text,
              style: AppTextStyles.semibold18,
              color: _getTextColor(),
              align: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
