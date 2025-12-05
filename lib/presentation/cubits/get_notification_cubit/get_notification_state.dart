part of 'get_notification_cubit.dart';

@immutable
sealed class GetNotificationState {}

final class GetNotificationInitial extends GetNotificationState {}

final class GetNotificationLoading extends GetNotificationState {}

final class GetNotificationSuccess extends GetNotificationState {
  final List<dynamic> notifications;

  GetNotificationSuccess({required this.notifications});
}

final class GetNotificationError extends GetNotificationState {
  final String message;

  GetNotificationError({required this.message});
}

