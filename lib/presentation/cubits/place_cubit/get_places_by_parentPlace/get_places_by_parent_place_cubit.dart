import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/repos/place_repo.dart';

part 'get_places_by_parent_place_state.dart';

class GetPlacesByParentPlaceCubit extends Cubit<GetPlacesByParentPlaceState> {
  GetPlacesByParentPlaceCubit({required this.placeRepo}) : super(GetPlacesByParentPlaceInitial());
  final PlaceRepo placeRepo;

  Future<void> getPlacesByParentPlace(String parentPlaceId) async {
    emit(GetPlacesByParentPlaceLoading());
    try {
      final places = await placeRepo.getPlacesByParentPlace(parentPlaceId);
      emit(GetPlacesByParentPlaceSuccess(places: places));
    } catch (e) {
      emit(GetPlacesByParentPlaceFailure(message: e.toString()));
    }
  }
}
