import 'package:app_android_b_0245_24/utils/app_colors.dart';
import 'package:app_android_b_0245_24/utils/app_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class AppIconButton extends StatefulWidget {
  final String assetName;
  final VoidCallback? onPressed;
  final bool isReversed;

  const AppIconButton({
    super.key,
    required this.assetName,
    required this.onPressed,
    this.isReversed = false,
  });

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  bool _isHighlighted = false;

  set isHighlighted(bool value) {
    setState(() {
      if (widget.onPressed != null) {
        _isHighlighted = value;
      }
    });
  }

  String _getBg() {
    String assetName;
    if (!widget.isReversed) {
      assetName = AppIcons.iconButtonBg;
      if (widget.onPressed == null || _isHighlighted) {
        assetName = AppIcons.iconButtonBgPressed;
      }
    } else {
      assetName = AppIcons.iconButtonBgPressed;
      if (widget.onPressed == null || _isHighlighted) {
        assetName = AppIcons.iconButtonBg;
      }
    }

    return assetName;
  }

  Color _getIconColor() {
    Color color;
    if (!widget.isReversed) {
      color = AppColors.accentPrimary1;
      if (widget.onPressed == null || _isHighlighted) {
        color = AppColors.layer2;
      }
    } else {
      color = AppColors.layer2;
      if (widget.onPressed == null || _isHighlighted) {
        color = AppColors.accentPrimary1;
      }
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
            height: 62,
            width: 59,
          ),
          SizedBox(
            height: 59,
            width: 59,
            child: Center(
              child: SvgPicture.asset(
                widget.assetName,
                color: _getIconColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
