import 'dart:io';

import 'package:app_android_b_0245_24/logic/models/user_model.dart';
import 'package:app_android_b_0245_24/logic/settings_controller.dart';
import 'package:app_android_b_0245_24/ui/view/loading_view.dart';
import 'package:app_android_b_0245_24/utils/app_colors.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //screen settings
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  FlameAudio.bgm.initialize();

  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);

  Hive.registerAdapter(UserModelAdapter());

  SettingsController.shared.getInitData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.accentPrimary1,
          primary: AppColors.accentSecondary1,
          outline: AppColors.layer1,
          surface: AppColors.accentPrimary1,
          onSurface: AppColors.textWhite,
          onSurfaceVariant: AppColors.accentPrimary1,
        ),
        useMaterial3: true,
      ),
      home: const LoadingView(),
    );
  }
}
