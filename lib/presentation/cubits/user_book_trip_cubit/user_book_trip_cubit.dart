import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repos/trip_repo.dart';

part 'user_book_trip_state.dart';

class UserBookTripCubit extends Cubit<UserBookTripState> {
  UserBookTripCubit({required this.tripRepo})
      : super(UserBookTripInitial());

  final TripRepo tripRepo;

  Future<void> bookTrip({
    required int tripId,
  }) async {
    emit(UserBookTripLoading());

    try {
      final response = await tripRepo.bookTrip(
        tripId: tripId,
      );

      emit(UserBookTripSuccess());
    } catch (e) {
      emit(UserBookTripFailure(message: e.toString(),
        ),
      );
    }
  }
}
