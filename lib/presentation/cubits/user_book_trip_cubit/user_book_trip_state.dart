part of 'user_book_trip_cubit.dart';

@immutable
sealed class UserBookTripState {}

final class UserBookTripInitial extends UserBookTripState {}

final class UserBookTripLoading extends UserBookTripState {}

final class UserBookTripSuccess extends UserBookTripState {}

final class UserBookTripFailure extends UserBookTripState {
  final String message;

  UserBookTripFailure({required this.message});
}
