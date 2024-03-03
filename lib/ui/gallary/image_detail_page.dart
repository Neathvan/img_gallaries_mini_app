import 'package:flutter/material.dart';
import 'package:img_gallaries_mini_app/model/igm_image.dart';
import 'package:img_gallaries_mini_app/ui/component/gallary/img_card.dart';

class ImageDetailPage extends StatefulWidget {
  const ImageDetailPage({super.key, required this.image});
  final IGMImage image;

  @override
  State<ImageDetailPage> createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
