import 'package:go_jo_user_application/data/models/place_models/place_homePage_model.dart';

import '../../domain/repos/place_repo.dart';
import '../../services/remote_data_source.dart';
import '../models/place_models/place_model.dart';
import '../models/place_models/place_top_rating_model.dart';
import '../models/review_model.dart';

class PlaceRepoImpl implements PlaceRepo {

  final RemoteDataSource remoteDataSource;

  PlaceRepoImpl({required this.remoteDataSource});

  @override
  Future<List<PlaceHomePageModel>> getAllPlaces() async {
    final response = await remoteDataSource.sendRequest(
      endpoint: '/place',
      method: 'GET',
    ) as List;

    return response
        .map((e) => PlaceHomePageModel.fromJson(e))
        .toList();
  }


  @override
  Future<List<PlaceHomePageModel>> getPlacesByParentPlace(String parentPlace) async {
    final response = await remoteDataSource.sendRequest(
      endpoint: '/place?parent_place=${parentPlace.toUpperCase()}',
      method: 'GET',
    ) as List;
    return response.map((e) => PlaceHomePageModel.fromJson(e)).toList();
  }


  @override
  Future<PlaceModel> getPlaceInfo(String placeName) async {
    final response = await remoteDataSource.sendRequest(
      endpoint: '/place/$placeName',
      method: 'GET',
    ) as Map;
    return PlaceModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<UserReviewModel> addReview({required int rating, required String review, required int placeId}) async {
    final response = await remoteDataSource.sendRequest(
      endpoint: '/place/$placeId/review',
      method: 'POST',
      data: {
        'rating': rating,
        'review': review,
      },
    ) as Map;
    return UserReviewModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<List<dynamic>> getTopRatingPlaces() async {
    final response = await remoteDataSource.sendRequest(
      endpoint: '/place/top_ratting/3',
      method: 'GET',
    ) as List;

    return response.map((e) => PlaceTopRatingModel.fromJson(e)).toList();
  }


}