import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:img_gallaries_mini_app/model/igm_image.dart';
import 'package:img_gallaries_mini_app/ui/component/gallary/image_block.dart';
import 'package:img_gallaries_mini_app/route/app_route.dart';
import 'package:img_gallaries_mini_app/util/igm_enum.dart';

class ImgCard extends StatelessWidget {
  final IGMImage image;
  final GallaryView view;
  const ImgCard({super.key, required this.image, this.view = GallaryView.grid});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.imageDetail,
            arguments: {'image': image}, preventDuplicates: false);
      },
      child: layout(),
    );
  }

  Widget layout() {
    switch (view) {
      case GallaryView.grid:
        return grid();
      case GallaryView.list:
        return ImageBlock(
                image: image,
                memCacheWidth: Get.width.toInt(),
                memCacheHeight: null)
            .marginSymmetric(horizontal: 16, vertical: 8);
    }
  }

  SizedBox grid() {
    return SizedBox(
      width: 100,
      height: 100,
      child: ImageBlock(image: image, borderRaduis: BorderRadius.circular(5)),
    );
  }
}
