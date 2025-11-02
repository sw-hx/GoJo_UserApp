class Trip {
  final String company;
  final DateTime launchTime;
  final DateTime returnTime;
  final double price;
  final String from;
  final String to;
  final String contactNumber;
  final String details;
  final List<String> features;
  final List<String> galleryImages;
  final String thumbnail;

  Trip({
  required this.company,
  required this.launchTime,
  required this.returnTime,
  required this.price,
  required this.from,
  required this.to,
  required this.contactNumber,
  required this.details,
  required this.features,
  required this.galleryImages,
  required this.thumbnail,
  });
}
