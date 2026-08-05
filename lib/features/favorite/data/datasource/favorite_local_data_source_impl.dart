import 'package:greeno_app/features/favorite/data/datasource/favorite_local_data_source.dart';
import 'package:greeno_app/features/favorite/data/models/favorite_item_hive_model.dart';
import 'package:greeno_app/features/favorite/domain/entities/favorite_item_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteLocalDataSourceImpl extends FavoriteLocalDataSource {
  final Box<FavoriteItemHiveModel> box;

  FavoriteLocalDataSourceImpl(this.box);

  @override
  Future<void> clearFavorite() async {
    await box.clear();
  }

  @override
  List<FavoriteItemEntity> getFavorite() {
    return box.values.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> saveFavorite(List<FavoriteItemEntity> items) async {
    final hiveItems =
    items.map((e) => FavoriteItemHiveModel.fromEntity(e)).toList();
    await box.clear();
    await box.addAll(hiveItems);
  }
}