import 'package:greeno_app/features/favorite/domain/entities/favorite_item_entity.dart';

abstract class FavoriteLocalDataSource {
  Future<void> saveFavorite(List<FavoriteItemEntity> items);

  List<FavoriteItemEntity> getFavorite();

  Future<void> clearFavorite();
}