import 'package:go_jo_user_application/services/remote_data_source.dart';
import '../../data/models/search_place_model.dart';
import '../../domain/repos/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final RemoteDataSource remoteDataSource;

  SearchRepoImpl({required this.remoteDataSource});

  @override
  Future<List<SearchPlaceModel>> searchPlaces(String query) async {
    final response = await remoteDataSource.sendRequest(
      endpoint: '/search/place?keyword=$query',
      method: 'GET',
    );

    final data = response as List;
    return data.map((e) => SearchPlaceModel.fromJson(e)).toList();
  }
}
