part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
  final List<FavoriteItemEntity> favorites;

  const FavoriteState({required this.favorites});

  FavoriteState copyWith({
    List<FavoriteItemEntity>? favorites,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [favorites];

}