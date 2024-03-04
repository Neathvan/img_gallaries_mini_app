import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:img_gallaries_mini_app/extention/widget_extension.dart';
import 'package:img_gallaries_mini_app/service/data_store_service.dart';
import 'package:img_gallaries_mini_app/util/app_color.dart';
import 'package:img_gallaries_mini_app/route/app_route.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initServices().then((value) => Get.offAndToNamed(RouteName.homePage));
    super.initState();
  }

  /// init local service for using local data
  Future initServices() async {
    ///starting services ...
    return await Get.putAsync(() => DataStoreService().init()).then((value) {
      ///All services started...
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FlutterLogo(size: 100),
          16.height,
          LoadingAnimationWidget.staggeredDotsWave(
              size: 100, color: AppColor.black)
        ],
      ),
    );
  }
}
