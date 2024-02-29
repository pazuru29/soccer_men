import 'package:app_android_b_0245_24/data/app_storage.dart';
import 'package:app_android_b_0245_24/logic/app_navigator.dart';
import 'package:app_android_b_0245_24/ui/components/app_back_button.dart';
import 'package:app_android_b_0245_24/ui/components/base_screen.dart';
import 'package:app_android_b_0245_24/ui/components/round_widget.dart';
import 'package:app_android_b_0245_24/ui/view/game/game_view.dart';
import 'package:app_android_b_0245_24/utils/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundsView extends BaseScreen {
  const RoundsView({super.key});

  @override
  State<RoundsView> createState() => _RoundsViewState();
}

class _RoundsViewState extends BaseScreenState<RoundsView> {
  List<Widget> _listOfRound = [];

  @override
  void initState() {
    _getListOfRounds();
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
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
                92, 70, 92, MediaQuery.paddingOf(context).bottom + 16),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              spacing: 10,
              children: [
                ..._listOfRound,
              ],
            ),
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

  void _getListOfRounds() {
    _listOfRound = [];
    for (final item in AppStorage.listOfRoundModels) {
      _listOfRound.add(RoundWidget(
        round: item,
        onPressed: () {
          AppNavigator.replaceToNextScreen(context, GameView(roundModel: item));
        },
      ));
    }
  }
}
