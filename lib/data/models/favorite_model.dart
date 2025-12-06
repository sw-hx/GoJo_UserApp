class FavoriteModel {
  final int favoriteId;
  final int placeId;
  final String placeName;
  final String placeMainPhotoUrl;
  final DateTime addToFavoriteAt;

  FavoriteModel({
    required this.favoriteId,
    required this.placeId,
    required this.placeName,
    required this.placeMainPhotoUrl,
    required this.addToFavoriteAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      favoriteId: json['favoriteId'] ?? 0,
      placeId: json['placeId'] ?? 0,
      placeName: json['placeName'] ?? '',
      placeMainPhotoUrl: json['placeMainPhotoUrl'] ?? '',
      addToFavoriteAt: DateTime.parse(json['addToFavoriteAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'favoriteId': favoriteId,
      'placeId': placeId,
      'placeName': placeName,
      'placeMainPhotoUrl': placeMainPhotoUrl,
      'addToFavoriteAt': addToFavoriteAt.toIso8601String(),
    };
  }

  FavoriteModel copyWith({
    int? favoriteId,
    int? placeId,
    String? placeName,
    String? placeMainPhotoUrl,
    DateTime? addToFavoriteAt,
  }) {
    return FavoriteModel(
      favoriteId: favoriteId ?? this.favoriteId,
      placeId: placeId ?? this.placeId,
      placeName: placeName ?? this.placeName,
      placeMainPhotoUrl: placeMainPhotoUrl ?? this.placeMainPhotoUrl,
      addToFavoriteAt: addToFavoriteAt ?? this.addToFavoriteAt,
    );
  }
}
