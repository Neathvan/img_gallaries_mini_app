import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:img_gallaries_mini_app/controller/gallary_controller.dart';
import 'package:img_gallaries_mini_app/service/config.dart';
import 'package:img_gallaries_mini_app/ui/home_page.dart';
import 'package:img_gallaries_mini_app/util/app_color.dart';
import 'package:img_gallaries_mini_app/util/app_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: IGMConfig.appName,
      initialBinding: HomeBinding(),
      getPages: AppRoute.pages,
      initialRoute: RouteName.homePage,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.mainColor),
          useMaterial3: true),
    );
  }
}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<GallaryController>(GallaryController());
  }
}
