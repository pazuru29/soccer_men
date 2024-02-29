import 'package:app_android_b_0245_24/utils/app_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class AppRoundIconButton extends StatefulWidget {
  final String assetName;
  final VoidCallback? onPressed;

  const AppRoundIconButton({
    super.key,
    required this.assetName,
    required this.onPressed,
  });

  @override
  State<AppRoundIconButton> createState() => _AppRoundIconButtonState();
}

class _AppRoundIconButtonState extends State<AppRoundIconButton> {
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
    assetName = AppIcons.roundIconBg;
    if (widget.onPressed == null || _isHighlighted) {
      assetName = AppIcons.roundIconBgActive;
    }

    return assetName;
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
            height: 67,
            width: 63,
          ),
          SizedBox(
            height: 67,
            width: 63,
            child: Center(
              child: SvgPicture.asset(widget.assetName),
            ),
          ),
        ],
      ),
    );
  }
}
