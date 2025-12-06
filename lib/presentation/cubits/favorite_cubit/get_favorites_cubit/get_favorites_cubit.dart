import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/favorite_model.dart';
import '../../../../domain/repos/favorite_repo.dart';

part 'get_favorites_state.dart';

class GetFavoritesCubit extends Cubit<GetFavoritesState> {
  GetFavoritesCubit({required this.favoriteRepo}) : super(GetFavoritesInitial());

  final FavoriteRepo favoriteRepo;

  Future<void> getFavorites() async {
    emit(GetFavoritesLoading());
    try {
      final favorites = await favoriteRepo.getFavorites();
      emit(GetFavoritesSuccess(favorites: favorites));
    } catch (e) {
      emit(GetFavoritesFailure(message: e.toString()));
    }
  }
}
