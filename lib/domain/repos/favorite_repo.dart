import '../../data/models/favorite_model.dart';

abstract class FavoriteRepo {

  Future<List<FavoriteModel>> getFavorites();

  Future<void> addFavorite({required int placeId});

  Future<void> removeFavorite({required int favoriteId});
}