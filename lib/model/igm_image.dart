import 'package:hive/hive.dart';
import 'package:img_gallaries_mini_app/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'igm_image.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
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

  IGMImage clone() => IGMImage();

  copyWith(IGMImage img) {
    id = img.id;
    url = img.url;
    author = img.author;
    width = img.width;
    height = img.height;
    downloadUrl = img.downloadUrl;

    if (isInBox) {
      save();
    }
  }

  factory IGMImage.fromJson(Map<String, dynamic> json) =>
      _$IGMImageFromJson(json);

  Map<String, dynamic> toJson() => _$IGMImageToJson(this);
}
