import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:img_gallaries_mini_app/controller/gallary_controller.dart';
import 'package:img_gallaries_mini_app/extention/textstyle_extension.dart';
import 'package:img_gallaries_mini_app/model/igm_image.dart';
import 'package:img_gallaries_mini_app/service/config.dart';
import 'package:img_gallaries_mini_app/ui/component/gallary/img_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(IGMConfig.appName, style: Get.textTheme.black13)),
      body: GetBuilder<GallaryController>(builder: (controller) {
        return EasyRefresh(
          // onRefresh: () => controller.getList(),
          // onLoad: () => controller.getList(loadMore: true),
          child: ValueListenableBuilder<Box<IGMImage>>(
              valueListenable: controller.gallaryBox.listenable(),
              builder: (context, box, child) {
                List<IGMImage>? gallary = (box.values).toList();
                return ListView.builder(
                  itemCount: (gallary).length,
                  itemBuilder: (context, i) {
                    IGMImage img = gallary[i];
                    return ImgCard(image: img);
                  },
                );
              }),
        );
      }),
    );
  }
}
