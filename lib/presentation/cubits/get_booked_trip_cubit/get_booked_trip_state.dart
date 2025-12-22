part of 'get_booked_trip_cubit.dart';

@immutable
sealed class GetBookedTripState {}

final class GetBookedTripInitial extends GetBookedTripState {}

final class GetBookedTripLoading extends GetBookedTripState {}

final class GetBookedTripSuccess extends GetBookedTripState {
  final List<TripModel> trips;

  GetBookedTripSuccess({required this.trips});
}

final class GetBookedTripEmpty extends GetBookedTripState {}

final class GetBookedTripFailure extends GetBookedTripState {
  final String message;

  GetBookedTripFailure({required this.message});
}
