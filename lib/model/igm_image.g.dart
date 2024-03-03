// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'igm_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IGMImageAdapter extends TypeAdapter<IGMImage> {
  @override
  final int typeId = 1;

  @override
  IGMImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IGMImage()
      ..url = fields[0] as String?
      ..id = fields[1] as String?
      ..author = fields[2] as String?
      ..width = fields[3] as int?
      ..height = fields[4] as int?
      ..downloadUrl = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, IGMImage obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.width)
      ..writeByte(4)
      ..write(obj.height)
      ..writeByte(5)
      ..write(obj.downloadUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IGMImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
