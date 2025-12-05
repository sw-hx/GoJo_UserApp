class NotificationModel {
  final int notificationId;
  final String sender;
  final String title;
  final String subtitle;
  final String message;

  NotificationModel({
    required this.notificationId,
    required this.sender,
    required this.title,
    required this.subtitle,
    required this.message,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['id'] ?? 0,
      sender: json['sender'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': notificationId,
      'sender': sender,
      'title': title,
      'subtitle': subtitle,
      'message': message,
    };
  }
}
