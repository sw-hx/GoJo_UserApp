import '../../data/models/place_models/place_model.dart';

abstract class PlaceRepo {

  Future<List<dynamic>> getAllPlaces();

  Future<List<dynamic>> getPlacesByParentPlace(String parentPlaceId);

  Future<PlaceModel> getPlaceInfo(String placeName);

}
