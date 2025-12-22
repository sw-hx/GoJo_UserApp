import '../../domain/repos/trip_repo.dart';
import '../../services/remote_data_source.dart';
import '../models/trip_model.dart';

class TripRepoImpl implements TripRepo {
  RemoteDataSource remoteDataSource;
  TripRepoImpl({required this.remoteDataSource});

  @override
  Future<List<TripModel>> getTrips({required int placeId}) async {

    final response = await remoteDataSource.sendRequest(
      endpoint: '/place/$placeId/trip',
      method: 'GET',
    );


    if (response is List) {
      return response.map((e) => TripModel.fromJson(e)).toList();
    }

    return [];
  }

  @override
  Future<void> bookTrip({required int tripId})async{
    final response = await remoteDataSource.sendRequest(
      endpoint: '/booking/$tripId',
      method: 'POST',
    );
  }

}