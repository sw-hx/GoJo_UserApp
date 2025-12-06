class EventModel {
  final int id;
  final String bigTitleName;
  final String backgroundPictureLink;
  final String eventInformation;
  final DateTime eventDate;

  EventModel({
    required this.id,
    required this.bigTitleName,
    required this.backgroundPictureLink,
    required this.eventInformation,
    required this.eventDate,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      bigTitleName: json['bigTitleName'],
      backgroundPictureLink: json['backgroundPictureLink'],
      eventInformation: json['eventInformation'],
      eventDate: DateTime.parse(json['eventDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bigTitleName': bigTitleName,
      'backgroundPictureLink': backgroundPictureLink,
      'eventInformation': eventInformation,
      'eventDate': eventDate.toIso8601String(),
    };
  }


  String get dateOnly {
    return "${eventDate.year}-${eventDate.month.toString().padLeft(2, '0')}-${eventDate.day.toString().padLeft(2, '0')}";
  }

  String get timeOnly {
    return "${eventDate.hour.toString().padLeft(2, '0')}:${eventDate.minute.toString().padLeft(2, '0')}";
  }

  String get formattedDate {
    return "${eventDate.day.toString().padLeft(2, '0')} ${_monthName(eventDate.month)} ${eventDate.year}";
  }

  String _monthName(int m) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[m - 1];
  }
}
