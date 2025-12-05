import '../../data/models/notification_model.dart';

abstract class NotificationRepo {

  Future<List<dynamic>> getNotification();

  Future<void> deleteNotification({required int notificationId});
}