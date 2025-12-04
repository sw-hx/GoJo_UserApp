part of 'get_trips_by_place_id_cubit.dart';

@immutable
sealed class GetTripsByPlaceIdState {}

final class GetTripsByPlaceIdInitial extends GetTripsByPlaceIdState {}

final class GetTripsByPlaceIdLoading extends GetTripsByPlaceIdState {}

final class GetTripsByPlaceIdSuccess extends GetTripsByPlaceIdState {
  final List<TripModel> trips;

  GetTripsByPlaceIdSuccess({required this.trips});
}

final class GetTripsByPlaceIdFailure extends GetTripsByPlaceIdState {
  final String message;

  GetTripsByPlaceIdFailure({required this.message});
}

