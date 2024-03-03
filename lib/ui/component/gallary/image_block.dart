import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:img_gallaries_mini_app/model/igm_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:img_gallaries_mini_app/util/app_color.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ImageBlock extends StatefulWidget {
  const ImageBlock(
      {super.key,
      this.enableRemoveImg = true,
      required this.image,
      this.borderRaduis,
      this.onTap,
      this.onError});

  final bool enableRemoveImg;
  final IGMImage image;
  final BorderRadiusGeometry? borderRaduis;
  final VoidCallback? onTap;
  final VoidCallback? onError;
  @override
  State<ImageBlock> createState() => _ImageBlockState();
}

class _ImageBlockState extends State<ImageBlock> {
  late CacheManager cacheManager;

  @override
  void initState() {
    super.initState();
  }

  Widget _imageW() {
    return CachedNetworkImage(
      imageUrl: widget.image.downloadUrl ?? '',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
            borderRadius: widget.borderRaduis,
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill)),
      ),
      placeholder: (context, url) => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.mainColor,
          borderRadius: widget.borderRaduis,
        ),
        child: LoadingAnimationWidget.beat(
            size: 40, color: AppColor.mainColor.withOpacity(1)),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 16 / 9, child: _imageW());
  }
}
