part of 'get_all_places_cubit.dart';

@immutable
sealed class GetAllPlacesState {}

final class GetAllPlacesInitial extends GetAllPlacesState {}

final class GetAllPlacesLoading extends GetAllPlacesState {}

final class GetAllPlacesSuccess extends GetAllPlacesState {
  final List<dynamic> places;
  GetAllPlacesSuccess({required this.places});
}

final class GetAllPlacesFailure extends GetAllPlacesState {
  final String message;
  GetAllPlacesFailure({required this.message});
}

