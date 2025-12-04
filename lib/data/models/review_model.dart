class UserReviewModel {
  final String? profilePhoto;
  final String userOwnReview;
  final int rating;
  final String review;
  final String reviewStatus;
  final DateTime createdAt;
  final DateTime lastTimeReviewEdit;

  UserReviewModel({
    this.profilePhoto,
    required this.userOwnReview,
    required this.rating,
    required this.review,
    required this.reviewStatus,
    required this.createdAt,
    required this.lastTimeReviewEdit,
  });

  factory UserReviewModel.fromJson(Map<String, dynamic> json) {
    return UserReviewModel(
      profilePhoto: json["profilePhoto"],
      userOwnReview: json["userOwnReview"],
      rating: json["rating"],
      review: json["review"],
      reviewStatus: json["reviewStatus"],
      createdAt: DateTime.parse(json["createdAt"]),
      lastTimeReviewEdit: DateTime.parse(json["lastTimeReviewEdit"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "profilePhoto": profilePhoto,
      "userOwnReview": userOwnReview,
      "rating": rating,
      "review": review,
      "reviewStatus": reviewStatus,
      "createdAt": createdAt.toIso8601String(),
      "lastTimeReviewEdit": lastTimeReviewEdit.toIso8601String(),
    };
  }
}
