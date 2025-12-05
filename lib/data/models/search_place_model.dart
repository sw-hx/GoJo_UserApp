class SearchPlaceModel {
  final int id;
  final String placeName;
  final String mainPhotoLink;

  SearchPlaceModel({
    required this.id,
    required this.placeName,
    required this.mainPhotoLink,
  });

  factory SearchPlaceModel.fromJson(Map<String, dynamic> json) {
    return SearchPlaceModel(
      id: json['id'],
      placeName: json['placeName'],
      mainPhotoLink: json['mainPhotoLink'],
    );
  }
}
