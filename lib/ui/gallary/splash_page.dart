import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:img_gallaries_mini_app/service/data_store_service.dart';
import 'package:img_gallaries_mini_app/util/app_route.dart';

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
      body: FlutterLogo(),
    );
  }
}
