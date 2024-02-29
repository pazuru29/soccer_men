import 'package:app_android_b_0245_24/logic/models/round_model.dart';
import 'package:flutter/material.dart';

class GameController {
  static RoundModel roundModel =
      RoundModel();

  static ValueNotifier<int> currentCoin = ValueNotifier(0);

  static ValueNotifier<int> currentLife = ValueNotifier(4);
}
