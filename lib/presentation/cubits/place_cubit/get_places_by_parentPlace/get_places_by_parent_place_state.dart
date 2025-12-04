part of 'get_places_by_parent_place_cubit.dart';

@immutable
sealed class GetPlacesByParentPlaceState {}

final class GetPlacesByParentPlaceInitial extends GetPlacesByParentPlaceState {}

final class GetPlacesByParentPlaceLoading extends GetPlacesByParentPlaceState {}

final class GetPlacesByParentPlaceSuccess extends GetPlacesByParentPlaceState {
  final List<dynamic> places;
  GetPlacesByParentPlaceSuccess({required this.places});
}

final class GetPlacesByParentPlaceFailure extends GetPlacesByParentPlaceState {
  final String message;
  GetPlacesByParentPlaceFailure({required this.message});
}

