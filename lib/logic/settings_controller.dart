import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:app_android_b_0245_24/logic/models/user_model.dart';
import 'package:app_android_b_0245_24/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class SettingsController {
  static final SettingsController shared = SettingsController._internal();

  factory SettingsController() {
    return shared;
  }

  SettingsController._internal();

  ValueNotifier<bool> isFirstRun = ValueNotifier(true);
  ValueNotifier<bool> isNeedMusic = ValueNotifier(true);
  ValueNotifier<Map<int, int>> starsPerRound = ValueNotifier({});

  ValueNotifier<UserModel> userModel = ValueNotifier(UserModel());

  void setInitData() {
    isFirstRun.value = true;
    isNeedMusic.value = true;
    userModel.value =UserModel();
    starsPerRound.value = {};
  }

  void getInitData() async {
    await Hive.openBox(kAppStorage).then((value) {
      isFirstRun.value = value.get(kIsFirstRun, defaultValue: true);
      isNeedMusic.value = value.get(kIsNeedMusic, defaultValue: true);
      userModel.value = value.get(kUserModel, defaultValue: UserModel());
      //Get data for stars from db
      starsPerRound.value = {};

      Map<dynamic, dynamic> tmpMap =
          value.get(kStarsPerRound, defaultValue: {});

      for (final item in tmpMap.entries.toList()) {
        starsPerRound.value[item.key] = item.value;
      }

      debugPrint(
          'FROM DB: ${isFirstRun.value} | ${isNeedMusic.value} | ${userModel.value} | ${starsPerRound.value}');
    });
  }

  void changeFirstRun(bool changeTo) async {
    await Hive.openBox(kAppStorage).then((value) {
      isFirstRun.value = changeTo;
      value.put(kIsFirstRun, changeTo);
    });
  }

  void changeNeedMusic(bool changeTo) async {
    await Hive.openBox(kAppStorage).then((value) {
      isNeedMusic.value = changeTo;
      value.put(kIsNeedMusic, changeTo);
    });
  }

  void saveUserName(String newName) async {
    await Hive.openBox(kAppStorage).then((value) {
      UserModel newUserModel =
          UserModel(name: newName, image: userModel.value.image);
      userModel.value = newUserModel;
      value.put(kUserModel, newUserModel);
    });
  }

  void saveUserPhoto(Uint8List newPhoto) async {
    await Hive.openBox(kAppStorage).then((value) {
      UserModel newUserModel =
          UserModel(name: userModel.value.name, image: newPhoto);
      userModel.value = newUserModel;
      value.put(kUserModel, newUserModel);
    });
  }

  void addNewStars(int roundNumber, int countOfStars) async {
    if (starsPerRound.value[roundNumber] == null) {
      starsPerRound.value[roundNumber] = countOfStars;
    } else {
      starsPerRound.value[roundNumber] =
          max(starsPerRound.value[roundNumber]!, countOfStars);
    }

    await Hive.openBox(kAppStorage).then((value) {
      value.put(kStarsPerRound, starsPerRound.value);
    });
  }

  Future<Uint8List?> getPhoto() async {
    File file;
    Uint8List? bytes;
    final ImagePicker picker = ImagePicker();
    //pick image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      file = File(image.path);
      bytes = await file.readAsBytes();
    }
    return bytes;
  }
}
