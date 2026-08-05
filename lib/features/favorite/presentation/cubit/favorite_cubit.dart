import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeno_app/features/favorite/data/datasource/favorite_local_data_source.dart';
import 'package:greeno_app/features/home/domain/entities/product_entity.dart';

import '../../domain/entities/favorite_item_entity.dart';

part 'favorite_state.dart';
class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteLocalDataSource localDataSource;
  FavoriteCubit(this.localDataSource): super(FavoriteState(favorites: localDataSource.getFavorite()));
  
  Future<void> toggleFavorite(ProductEntity product) async{
    final favorites = List<FavoriteItemEntity>.from(state.favorites);
    final index = favorites.indexWhere(
        (item) => item.product.id == product.id,
    );
    if(index == -1){
      favorites.add(FavoriteItemEntity(product: product));
    }
    else{
      favorites.removeAt(index);
    }
    await localDataSource.saveFavorite(favorites);
    emit(state.copyWith(favorites: favorites));
  }
  bool isFavorite(ProductEntity product) {
    return state.favorites.any(
          (item) => item.product.id == product.id,
    );
  }
}