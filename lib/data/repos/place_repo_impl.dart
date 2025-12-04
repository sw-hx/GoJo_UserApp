import 'package:go_jo_user_application/data/models/place_models/place_homePage_model.dart';

import '../../domain/repos/place_repo.dart';
import '../../services/auth_remote_data_source.dart';
import '../models/place_models/place_model.dart';

class PlaceRepoImpl implements PlaceRepo {

  final AuthRemoteDataSource authRemoteDataSource;

  PlaceRepoImpl({required this.authRemoteDataSource});

  @override
  Future<List<PlaceHomePageModel>> getAllPlaces() async {
    final response = await authRemoteDataSource.sendRequest(
      endpoint: '/place',
      method: 'GET',
    ) as List;

    return response
        .map((e) => PlaceHomePageModel.fromJson(e))
        .toList();
  }


  @override
  Future<List<PlaceModel>> getPlacesByParentPlace(String parentPlaceId) async {
    final response = await authRemoteDataSource.sendRequest(
      endpoint: '/place/parent/$parentPlaceId',
      method: 'GET',
    ) as List;
    return response.map((e) => PlaceModel.fromJson(e)).toList();
  }

  @override
  Future<PlaceModel> getPlaceInfo(String placeName) async {
    final response = await authRemoteDataSource.sendRequest(
      endpoint: '/place/$placeName',
      method: 'GET',
    ) as Map;
    return PlaceModel.fromJson(response as Map<String, dynamic>);
  }
}