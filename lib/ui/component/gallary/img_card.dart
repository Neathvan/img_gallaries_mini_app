import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:img_gallaries_mini_app/model/igm_image.dart';
import 'package:img_gallaries_mini_app/ui/component/gallary/image_block.dart';
import 'package:img_gallaries_mini_app/util/app_route.dart';

class ImgCard extends StatelessWidget {
  final IGMImage image;
  const ImgCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.imageDetail, arguments: {'image': image});
      },
      child: SizedBox(
        width: 80,
        height: 80,
        child: ImageBlock(image: image, borderRaduis: BorderRadius.circular(5)),
      ),
    );
  }
}
