import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/repos/favorite_repo.dart';

part 'delete_favorite_state.dart';

class DeleteFavoriteCubit extends Cubit<DeleteFavoriteState> {
  DeleteFavoriteCubit({required this.favoriteRepo}) : super(DeleteFavoriteInitial());
  final FavoriteRepo favoriteRepo;

  Future<void> deleteFavorite({required int favoriteId}) async {
    emit(DeleteFavoriteLoading());
    try {
      await favoriteRepo.removeFavorite(favoriteId: favoriteId);
      emit(DeleteFavoriteSuccess());
    } catch (e) {
      emit(DeleteFavoriteFailure(message: e.toString()));
    }
  }
}
