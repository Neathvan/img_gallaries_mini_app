import 'dart:developer';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:img_gallaries_mini_app/controller/gallary_controller.dart';
import 'package:img_gallaries_mini_app/extention/widget_extension.dart';
import 'package:img_gallaries_mini_app/model/igm_image.dart';
import 'package:img_gallaries_mini_app/ui/component/gallary/image_block.dart';

class ImageDetailPage extends StatefulWidget {
  const ImageDetailPage({super.key, required this.image});
  final IGMImage image;

  @override
  State<ImageDetailPage> createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  final GallaryController controller = Get.find();
  late IGMImage image;
  @override
  void initState() {
    image = widget.image;
    controller.getImageDetail(widget.image);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: SafeArea(
        child: GetBuilder(
            init: controller,
            builder: (controller) {
              return EasyRefresh(
                  child: ValueListenableBuilder<Box<IGMImage>>(
                valueListenable:
                    controller.gallaryBox.listenable(keys: [image]),
                builder: (context, box, child) {
                  return ListView(
                    children: [
                      ImageBlock(image: image),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          cellItem("id", image.id),
                          cellItem("author", image.author),
                          cellItem("width", image.width),
                          cellItem("height", image.height),
                          cellItem("url", image.url),
                          cellItem("download url", image.downloadUrl)
                        ],
                      ).marginAll(16)
                    ],
                  );
                },
              ));
            }),
      ),
    );
  }

  Widget cellItem(String title, value) =>
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title.capitalizeFirst! + '\t:'),
        16.width,
        Flexible(child: Text((value ?? '-').toString()))
      ]).marginOnly(bottom: 16);
}
