// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'igm_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IGMImage _$IGMImageFromJson(Map<String, dynamic> json) => IGMImage()
  ..url = json['url'] as String?
  ..name = json['name'] as String?
  ..largeUrl = json['large_url'] as String?
  ..mediumUrl = json['medium_url'] as String?
  ..text = json['text'] as String?
  ..image = json['image'] as String? ?? ''
  ..path = json['path'] as int;

Map<String, dynamic> _$IGMImageToJson(IGMImage instance) => <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'large_url': instance.largeUrl,
      'medium_url': instance.mediumUrl,
      'text': instance.text,
      'image': instance.image,
      'path': instance.path,
    };
