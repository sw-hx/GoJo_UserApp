class PlaceHomePageModel {
  final String placeName;
  final String quickInfo;
  final String mainPhotoLink;

  PlaceHomePageModel({
    required this.placeName,
    required this.quickInfo,
    required this.mainPhotoLink,
  });

  factory PlaceHomePageModel.fromJson(Map<String, dynamic> json) {
    return PlaceHomePageModel(
      placeName: json["placeName"],
      quickInfo: json["quickInfo"],
      mainPhotoLink: json["mainPhotoLink"],
    );
  }
}
