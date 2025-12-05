import '../../data/models/search_place_model.dart';

abstract class SearchRepo {

  Future<List<SearchPlaceModel>> searchPlaces(String query);
}