import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:img_gallaries_mini_app/extention/textstyle_extension.dart';
import 'package:img_gallaries_mini_app/service/config.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(IGMConfig.appName, style: Get.textTheme.black15W600)),
      body: SingleChildScrollView(
        child: Wrap(
          children: [],
        ),
      ),
    );
  }
}
