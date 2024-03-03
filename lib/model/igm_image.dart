import 'dart:io';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:img_gallaries_mini_app/model/base_model.dart';
import 'package:img_gallaries_mini_app/util/igm_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'igm_image.g.dart';

@JsonSerializable()
class IGMImage extends BaseModel {
  static const boxName = 'IGMImage';
  IGMImage();

  @HiveField(0)
  String? url;

  @HiveField(1)
  @JsonValue('')
  String? id;

  @HiveField(2)
  String? author;

  @HiveField(3)
  int? width;

  @HiveField(4)
  int? height;

  @HiveField(5)
  @JsonKey(defaultValue: '')
  @JsonValue('')
  String? downloadUrl;

  // @JsonKey(ignore: true)
  // @JsonValue(0)
  // late int path;

  ///
  @JsonKey(ignore: true)
  File? file;

  @JsonKey(ignore: true)
  Rx<APIStatus> uploadFileStatus = APIStatus.empty.obs;

  @JsonValue(true)
  @JsonKey(ignore: true)
  bool isOnServer = true;

  IGMImage clone() => IGMImage();

  factory IGMImage.fromJson(Map<String, dynamic> json) =>
      _$IGMImageFromJson(json);

  Map<String, dynamic> toJson() => _$IGMImageToJson(this);
}
