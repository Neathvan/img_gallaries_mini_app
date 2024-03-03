import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:img_gallaries_mini_app/extention/textstyle_extension.dart';
import 'package:img_gallaries_mini_app/extention/widget_extension.dart';
import 'package:img_gallaries_mini_app/model/igm_image.dart';
import 'package:img_gallaries_mini_app/ui/component/gallary/image_block.dart';

class ImgCard extends StatelessWidget {
  final IGMImage image;
  const ImgCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ImageBlock(image: image),
          8.height,
          Text.rich(
            TextSpan(
                text: 'Author\t:\t', children: [TextSpan(text: image.author)]),
            textAlign: TextAlign.left,
            style: Get.textTheme.black13W600.copyWith(fontSize: 20),
          )
        ]),
      ),
    );
  }
}
