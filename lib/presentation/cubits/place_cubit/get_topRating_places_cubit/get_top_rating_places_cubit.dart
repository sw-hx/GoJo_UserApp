import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/place_models/place_homePage_model.dart';
import '../../../../domain/repos/place_repo.dart';

part 'get_top_rating_places_state.dart';

class GetTopRatingPlacesCubit extends Cubit<GetTopRatingPlacesState> {
  GetTopRatingPlacesCubit({required this.placeRepo}) : super(GetTopRatingPlacesInitial());
  final PlaceRepo placeRepo;

  Future<void> getTopRatingPlaces() async {
    emit(GetTopRatingPlacesLoading());
    try {
      final places = await placeRepo.getTopRatingPlaces();
      emit(GetTopRatingPlacesSuccess(places: places));
    } catch (e) {
      emit(GetTopRatingPlacesFailure(message: e.toString()));
    }
  }
}
