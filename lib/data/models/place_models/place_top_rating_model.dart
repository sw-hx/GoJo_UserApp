class PlaceTopRatingModel {
  final int id;
  final String name;
  final double rating;
  final String mainPhoto;

  PlaceTopRatingModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.mainPhoto,
  });

  factory PlaceTopRatingModel.fromJson(Map<String, dynamic> json) {
    double rawRating = double.tryParse(json['placeAvgRate'].toString()) ?? 0.0;

    return PlaceTopRatingModel(
      id: json['placeId'],
      name: json['placeName'],
      rating: double.parse(rawRating.toStringAsFixed(1)),
      mainPhoto: json['mainPhotoLink'],
    );
  }
}
