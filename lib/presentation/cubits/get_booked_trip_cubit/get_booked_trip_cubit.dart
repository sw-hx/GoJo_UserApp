import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/trip_model.dart';
import '../../../domain/repos/trip_repo.dart';

part 'get_booked_trip_state.dart';

class GetBookedTripCubit extends Cubit<GetBookedTripState> {
  GetBookedTripCubit({required this.tripRepo})
      : super(GetBookedTripInitial());

  final TripRepo tripRepo;

  Future<void> getBookedTrips() async {
    emit(GetBookedTripLoading());

    try {
      final List<TripModel> trips = await tripRepo.getBookedTrips();

      if (trips.isEmpty) {
        emit(GetBookedTripEmpty());
      } else {
        emit(GetBookedTripSuccess(trips: trips));
      }
    } catch (e) {
      emit(
        GetBookedTripFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
