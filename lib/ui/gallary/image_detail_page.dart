import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:img_gallaries_mini_app/controller/gallary_controller.dart';
import 'package:img_gallaries_mini_app/extention/widget_extension.dart';
import 'package:img_gallaries_mini_app/model/igm_image.dart';
import 'package:img_gallaries_mini_app/service/api_result.dart';
import 'package:img_gallaries_mini_app/ui/component/gallary/image_block.dart';

class ImageDetailPage extends StatefulWidget {
  const ImageDetailPage({super.key, required this.image});
  final IGMImage image;

  @override
  State<ImageDetailPage> createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  final GallaryController controller = Get.find();

  @override
  void initState() {
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
              ApiResult<IGMImage> imageResult = controller.imageDetailResult;
              return EasyRefresh(
                  child: ListView(
                children: [
                  ImageBlock(image: imageResult.data!),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cellItem("id", imageResult.data!.id),
                      cellItem("author", imageResult.data!.author),
                      cellItem("width", imageResult.data!.width),
                      cellItem("height", imageResult.data!.height),
                      cellItem("url", imageResult.data!.url),
                      cellItem("download url", imageResult.data!.downloadUrl)
                    ],
                  ).marginAll(16)
                ],
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
