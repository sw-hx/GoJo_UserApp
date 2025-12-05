import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/search_place_model.dart';
import '../../../domain/repos/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo repo;

  SearchCubit({required this.repo}) : super(SearchInitial());

  Future<void> search(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    try {
      final results = await repo.searchPlaces(query);
      emit(SearchSuccess(places: results));
    } catch (e) {
      emit(SearchFailure(message: e.toString()));
    }
  }
}

