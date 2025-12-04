import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/review_model.dart';
import '../../../../domain/repos/place_repo.dart';

part 'write_comment_state.dart';

class WriteCommentCubit extends Cubit<WriteCommentState> {
  WriteCommentCubit({required this.placeRepo}) : super(WriteCommentInitial());
  PlaceRepo placeRepo;

  Future<void> addReview({required int rating, required String reviewText, required int placeId}) async {
    emit(WriteCommentLoading());
    try {
      final review = await placeRepo.addReview(rating: rating, review: reviewText, placeId: placeId);
      emit(WriteCommentSuccess(review: review));
    } catch (e) {
      emit(WriteCommentError(message: e.toString()));
    }
  }
}
