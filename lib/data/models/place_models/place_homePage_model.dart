class PlaceHomePageModel {
  final String placeName;
  final String quickInfo;
  final String mainPhotoLink;
  final bool isFavorite;

  PlaceHomePageModel({
    required this.placeName,
    required this.quickInfo,
    required this.mainPhotoLink,
    required this.isFavorite,
  });

  factory PlaceHomePageModel.fromJson(Map<String, dynamic> json) {
    return PlaceHomePageModel(
      placeName: json["placeName"],
      quickInfo: json["quickInfo"],
      mainPhotoLink: json["mainPhotoLink"],
      isFavorite: json["isFavorite"],
    );
  }
}
