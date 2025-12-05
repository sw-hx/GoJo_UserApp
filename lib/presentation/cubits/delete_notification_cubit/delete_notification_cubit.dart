import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repos/notification_repo.dart';

part 'delete_notification_state.dart';

class DeleteNotificationCubit extends Cubit<DeleteNotificationState> {
  DeleteNotificationCubit({required this.notificationRepo}) : super(DeleteNotificationInitial());
  final NotificationRepo notificationRepo;

  Future<void> deleteNotification(int notificationId) async {
    emit(DeleteNotificationLoading());
    try {
      await notificationRepo.deleteNotification(notificationId: notificationId);
      emit(DeleteNotificationSuccess());
    } catch (e) {
      emit(DeleteNotificationError(message: e.toString()));
    }
  }
}
