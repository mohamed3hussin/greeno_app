// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_item_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteItemHiveModelAdapter extends TypeAdapter<FavoriteItemHiveModel> {
  @override
  final int typeId = 2;

  @override
  FavoriteItemHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteItemHiveModel(
      product: fields[0] as ProductHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteItemHiveModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.product);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteItemHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
