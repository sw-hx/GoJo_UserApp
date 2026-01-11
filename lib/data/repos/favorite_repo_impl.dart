import '../../domain/repos/favorite_repo.dart';
import '../../services/remote_data_source.dart';
import '../models/favorite_model.dart';

class FavoriteRepoImpl implements FavoriteRepo {
  final RemoteDataSource remoteDataSource;

  FavoriteRepoImpl({required this.remoteDataSource});

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    try {
      final response = await remoteDataSource.sendRequest(
        endpoint: '/favorite',
        method: 'GET',
      );

      return (response as List).map((e) => FavoriteModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addFavorite({required int placeId}) async {
    try {
      final response = await remoteDataSource.sendRequest(
        endpoint: '/favorite/$placeId',
        method: 'POST',
        data: {},
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeFavorite({required int favoriteId}) async {
    try {
      final response = await remoteDataSource.sendRequest(
        endpoint: '/favorite/$favoriteId',
        method: 'DELETE',
      );
    } catch (e) {
      rethrow;
    }
  }
}
