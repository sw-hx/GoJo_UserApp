part of 'get_top_rating_places_cubit.dart';

@immutable
sealed class GetTopRatingPlacesState {}

final class GetTopRatingPlacesInitial extends GetTopRatingPlacesState {}

final class GetTopRatingPlacesLoading extends GetTopRatingPlacesState {}

final class GetTopRatingPlacesSuccess extends GetTopRatingPlacesState {
  final List<dynamic> places;
  GetTopRatingPlacesSuccess({required this.places});
}

final class GetTopRatingPlacesFailure extends GetTopRatingPlacesState {
  final String message;
  GetTopRatingPlacesFailure({required this.message});
}

