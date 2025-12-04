part of 'write_comment_cubit.dart';

@immutable
sealed class WriteCommentState {}

final class WriteCommentInitial extends WriteCommentState {}

final class WriteCommentLoading extends WriteCommentState {}

final class WriteCommentSuccess extends WriteCommentState {
  final UserReviewModel review;
  WriteCommentSuccess({required this.review});
}

final class WriteCommentError extends WriteCommentState {
  final String message;
  WriteCommentError({required this.message});
}

