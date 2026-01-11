abstract class NotificationRepo {
  Future<List<dynamic>> getNotification();

  Future<void> deleteNotification({required int notificationId});
}
