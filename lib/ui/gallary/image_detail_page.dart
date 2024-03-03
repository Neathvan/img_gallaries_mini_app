import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:img_gallaries_mini_app/controller/gallary_controller.dart';
import 'package:img_gallaries_mini_app/model/igm_image.dart';

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
    controller.getImageDetail(image.id!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (controller) {
          return EasyRefresh(
              child: ListView(
            children: [],
          ));
        });
  }
}
