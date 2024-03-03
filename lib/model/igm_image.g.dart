// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'igm_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IGMImage _$IGMImageFromJson(Map<String, dynamic> json) => IGMImage()
  ..url = json['url'] as String?
  ..id = json['id'] as String?
  ..author = json['author'] as String?
  ..width = json['width'] as int?
  ..height = json['height'] as int?
  ..downloadUrl = json['download_url'] as String? ?? '';

Map<String, dynamic> _$IGMImageToJson(IGMImage instance) => <String, dynamic>{
      'url': instance.url,
      'id': instance.id,
      'author': instance.author,
      'width': instance.width,
      'height': instance.height,
      'download_url': instance.downloadUrl,
    };
