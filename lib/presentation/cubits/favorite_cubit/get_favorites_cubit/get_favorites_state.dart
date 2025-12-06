part of 'get_favorites_cubit.dart';

@immutable
sealed class GetFavoritesState {}

final class GetFavoritesInitial extends GetFavoritesState {}

final class GetFavoritesLoading extends GetFavoritesState {}

final class GetFavoritesSuccess extends GetFavoritesState {
  final List<FavoriteModel> favorites;

  GetFavoritesSuccess({required this.favorites});
}

final class GetFavoritesFailure extends GetFavoritesState {
  final String message;

  GetFavoritesFailure({required this.message});
}

