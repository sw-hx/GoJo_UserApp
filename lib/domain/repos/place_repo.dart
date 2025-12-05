import '../../data/models/place_models/place_model.dart';
import '../../data/models/review_model.dart';

abstract class PlaceRepo {

  Future<List<dynamic>> getAllPlaces();

  Future<List<dynamic>> getPlacesByParentPlace(String parentPlace);

  Future<List<dynamic>> getTopRatingPlaces();

  Future<PlaceModel> getPlaceInfo(String placeName);

  Future<UserReviewModel> addReview({required int rating, required String review, required int placeId});

}
