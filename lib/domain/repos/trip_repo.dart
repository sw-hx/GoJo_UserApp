import '../../data/models/trip_model.dart';

abstract class TripRepo {

  Future<List<TripModel>> getTrips({required int placeId});

  Future<void> bookTrip({required int tripId});

  Future<List<TripModel>> getBookedTrips();


}