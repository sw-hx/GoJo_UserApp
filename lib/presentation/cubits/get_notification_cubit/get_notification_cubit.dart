import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repos/notification_repo.dart';

part 'get_notification_state.dart';

class GetNotificationCubit extends Cubit<GetNotificationState> {
  GetNotificationCubit({required this.notificationRepo})
    : super(GetNotificationInitial());

  final NotificationRepo notificationRepo;

  Future<void> getNotification() async {
    emit(GetNotificationLoading());
    try {
      final notifications = await notificationRepo.getNotification();
      emit(GetNotificationSuccess(notifications: notifications));
    } catch (e) {
      emit(GetNotificationError(message: e.toString()));
    }
  }
}
