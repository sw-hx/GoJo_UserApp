part of 'delete_favorite_cubit.dart';

@immutable
sealed class DeleteFavoriteState {}

final class DeleteFavoriteInitial extends DeleteFavoriteState {}

final class DeleteFavoriteLoading extends DeleteFavoriteState {}

final class DeleteFavoriteSuccess extends DeleteFavoriteState {}

final class DeleteFavoriteFailure extends DeleteFavoriteState {
  final String message;

  DeleteFavoriteFailure({required this.message});
}

