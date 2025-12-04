import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/place_models/place_model.dart';
import '../../../../domain/repos/place_repo.dart';

part 'get_place_info_state.dart';

class GetPlaceInfoCubit extends Cubit<GetPlaceInfoState> {
  GetPlaceInfoCubit({required this.placeRepo}) : super(GetPlaceInfoInitial());
  final PlaceRepo placeRepo;

  Future<void> getPlaceInfo(String placeName) async {
    emit(GetPlaceInfoLoading());
    try {
      final place = await placeRepo.getPlaceInfo(placeName);
      emit(GetPlaceInfoSuccess(place: place));
    } catch (e) {
      emit(GetPlaceInfoFailure(message: e.toString()));
    }
  }
}
