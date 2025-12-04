part of 'get_place_info_cubit.dart';

@immutable
sealed class GetPlaceInfoState {}

final class GetPlaceInfoInitial extends GetPlaceInfoState {}
final class GetPlaceInfoLoading extends GetPlaceInfoState {}
final class GetPlaceInfoSuccess extends GetPlaceInfoState {
  final PlaceModel place;
  GetPlaceInfoSuccess({required this.place});
}
final class GetPlaceInfoFailure extends GetPlaceInfoState {
  final String message;
  GetPlaceInfoFailure({required this.message});
}

