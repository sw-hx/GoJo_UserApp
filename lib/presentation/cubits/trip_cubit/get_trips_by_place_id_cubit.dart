import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/trip_model.dart';
import '../../../domain/repos/trip_repo.dart';

part 'get_trips_by_place_id_state.dart';

class GetTripsByPlaceIdCubit extends Cubit<GetTripsByPlaceIdState> {
  GetTripsByPlaceIdCubit({required this.tripRepo}) : super(GetTripsByPlaceIdInitial());
  TripRepo tripRepo;

  Future<void> getTripsByPlaceId({required int placeId}) async {
    emit(GetTripsByPlaceIdLoading());
    try {
      final trips = await tripRepo.getTrips(placeId: placeId);
      emit(GetTripsByPlaceIdSuccess(trips: trips));
    } catch (e) {
      emit(GetTripsByPlaceIdFailure(message: e.toString()));
    }
  }
}
