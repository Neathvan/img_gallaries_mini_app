import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:img_gallaries_mini_app/model/igm_image.dart';
import 'package:img_gallaries_mini_app/util/app_color.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ImageBlock extends StatefulWidget {
  const ImageBlock(
      {super.key,
      required this.image,
      this.borderRaduis,
      this.memCacheHeight = 100,
      this.memCacheWidth = 100});

  final IGMImage image;
  final BorderRadiusGeometry? borderRaduis;
  final int? memCacheHeight, memCacheWidth;
  @override
  State<ImageBlock> createState() => _ImageBlockState();
}

class _ImageBlockState extends State<ImageBlock> {
  @override
  void initState() {
    super.initState();
  }

  Widget _imageW() {
    return CachedNetworkImage(
        imageUrl: widget.image.downloadUrl ?? '',
        memCacheHeight: widget.memCacheHeight,
        memCacheWidth: widget.memCacheWidth,
        fit: BoxFit.fill,
        placeholder: (context, url) => Container(
            color: AppColor.mainColor,
            alignment: Alignment.center,
            child: LoadingAnimationWidget.staggeredDotsWave(
                size: 20, color: AppColor.black)),
        errorWidget: (context, url, error) => const Icon(Icons.error));
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 16 / 9, child: _imageW());
  }
}
