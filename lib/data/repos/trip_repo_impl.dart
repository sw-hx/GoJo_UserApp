import '../../domain/repos/trip_repo.dart';
import '../../services/auth_remote_data_source.dart';
import '../models/trip_model.dart';

class TripRepoImpl implements TripRepo {
  AuthRemoteDataSource authRemoteDataSource;
  TripRepoImpl({required this.authRemoteDataSource});

  Future<List<TripModel>> getTrips({required int placeId}) async {

    final response = await authRemoteDataSource.sendRequest(
      endpoint: '/place/$placeId/trip',
      method: 'GET',
    );

    print("RAW RESPONSE => $response");

    if (response is List) {
      return response.map((e) => TripModel.fromJson(e)).toList();
    }

    return [];
  }

}