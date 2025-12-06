import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/repos/favorite_repo.dart';

part 'add_favorite_state.dart';

class AddFavoriteCubit extends Cubit<AddFavoriteState> {
  AddFavoriteCubit({required this.favoriteRepo}) : super(AddFavoriteInitial());
  final FavoriteRepo favoriteRepo;

  Future<void> addFavorite(int placeId) async {
    emit(AddFavoriteLoading());
    try {
      await favoriteRepo.addFavorite(placeId: placeId);
      emit(AddFavoriteSuccess());
    } catch (e) {
      emit(AddFavoriteFailure(message: e.toString()));
    }
  }
}
