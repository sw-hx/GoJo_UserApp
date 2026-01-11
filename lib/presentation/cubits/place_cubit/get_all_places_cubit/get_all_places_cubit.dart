import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/repos/place_repo.dart';

part 'get_all_places_state.dart';

class GetAllPlacesCubit extends Cubit<GetAllPlacesState> {
  GetAllPlacesCubit({required this.placeRepo}) : super(GetAllPlacesInitial());
  final PlaceRepo placeRepo;

  Future<void> getAllPlaces() async {
    emit(GetAllPlacesLoading());
    try {
      final places = await placeRepo.getAllPlaces();
      emit(GetAllPlacesSuccess(places: places));
    } catch (e) {
      emit(GetAllPlacesFailure(message: e.toString()));
    }
  }
}
