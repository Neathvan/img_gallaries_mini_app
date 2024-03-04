import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:img_gallaries_mini_app/util/config.dart';
import 'package:img_gallaries_mini_app/util/app_color.dart';
import 'package:img_gallaries_mini_app/route/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: IGMConfig.appName,
      getPages: AppRoute.pages,
      initialRoute: RouteName.splashPage,
      builder: EasyLoading.init(),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.mainColor)),
    );
  }
}
