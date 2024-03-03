import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:img_gallaries_mini_app/controller/gallary_controller.dart';
import 'package:img_gallaries_mini_app/extention/textstyle_extension.dart';
import 'package:img_gallaries_mini_app/extention/widget_extension.dart';
import 'package:img_gallaries_mini_app/model/igm_image.dart';
import 'package:img_gallaries_mini_app/service/api_result.dart';
import 'package:img_gallaries_mini_app/ui/component/gallary/image_block.dart';
import 'package:img_gallaries_mini_app/ui/component/gallary/img_card.dart';

class ImageDetailPage extends StatefulWidget {
  const ImageDetailPage({super.key, required this.image});
  final IGMImage image;

  @override
  State<ImageDetailPage> createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  final GallaryController controller = Get.find<GallaryController>();
  late IGMImage image;

  @override
  void initState() {
    image = widget.image;
    getDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: SafeArea(
        child: GetBuilder<GallaryController>(
            init: controller,
            builder: (controller) {
              return EasyRefresh(
                  header: const MaterialHeader(clamping: false),
                  onRefresh: getDetail,
                  child: ValueListenableBuilder<Box<IGMImage>>(
                    valueListenable: controller.gallaryBox.listenable(),
                    builder: (context, box, child) {
                      List<IGMImage>? gallary = box.values.toList()..shuffle();

                      return ListView(
                        children: [
                          ImageBlock(image: image),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Image detail".toUpperCase(),
                                style: Get.textTheme.blue17W600,
                              ),
                              8.height,
                              cellItem("id", image.id),
                              cellItem("author", image.author),
                              cellItem("width", image.width),
                              cellItem("height", image.height),
                              cellItem("url", image.url),
                              cellItem("download url", image.downloadUrl)
                            ],
                          ).marginAll(16),
                          28.height,
                          Align(
                            alignment: Alignment.topCenter,
                            child: Wrap(
                                spacing: 10.0,
                                runSpacing: 10.0,
                                children: gallary
                                    .take(10)
                                    .map((e) => ImgCard(image: e))
                                    .toList()),
                          )
                        ],
                      );
                    },
                  ));
            }),
      ),
    );
  }

  Future<ApiResult<IGMImage>> getDetail() async =>
      await controller.getImageDetail(widget.image).then((value) {
        return value;
      });

  Widget cellItem(String title, value) =>
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title.capitalizeFirst! + '\t:'),
        16.width,
        Flexible(
            child: Text((value ?? '-').toString(),
                style: Get.textTheme.black13W600))
      ]).marginOnly(bottom: 16);
}
