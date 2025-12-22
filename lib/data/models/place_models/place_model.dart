import 'package:go_jo_user_application/data/models/review_model.dart';
import 'package:go_jo_user_application/data/models/weather_model.dart';

class PlaceModel {
  final int placeId;
  final String parentPlace;
  final String mainPhotoLink;
  final String placeName;
  final String quickInfo;
  final String placeInfo;
  final String bestSeasonToVisit;
  final int? totalNumberOfVisitor;
  final int? onThisYear;
  final bool isSevenWonder;
  final String subPhotoOneLink;
  final String subPhotoTwoLink;
  final String subPhotoThreeLink;
  final String subPhotoFourLink;
  final String subPhotoFiveLink;
  final String placeLocation;
  final double averagePlaceRating;
  final UserReviewModel? userReview;
  final List<UserReviewModel> listAllUsersReviews;
  final bool isFavorite;
  final List<WeatherModel> weatherResponse;

  PlaceModel({
    required this.placeId,
    required this.parentPlace,
    required this.mainPhotoLink,
    required this.placeName,
    required this.quickInfo,
    required this.placeInfo,
    required this.bestSeasonToVisit,
    this.totalNumberOfVisitor,
    this.onThisYear,
    required this.isSevenWonder,
    required this.subPhotoOneLink,
    required this.subPhotoTwoLink,
    required this.subPhotoThreeLink,
    required this.subPhotoFourLink,
    required this.subPhotoFiveLink,
    required this.placeLocation,
    required this.averagePlaceRating,
    required this.userReview,
    required this.listAllUsersReviews,
    required this.isFavorite,
    required this.weatherResponse,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      placeId: json["placeId"],
      parentPlace: json["parentPlace"],
      mainPhotoLink: json["mainPhotoLink"],
      placeName: json["placeName"],
      quickInfo: json["quickInfo"],
      placeInfo: json["placeInfo"],
      bestSeasonToVisit: json["bestSeasonToVisit"],
      totalNumberOfVisitor: json["totalNumberOfVisitor"],
      onThisYear: json["onThisYear"],
      isSevenWonder: json["isSevenWonder"],
      subPhotoOneLink: json["subPhotoOneLink"],
      subPhotoTwoLink: json["subPhotoTwoLink"],
      subPhotoThreeLink: json["subPhotoThreeLink"],
      subPhotoFourLink: json["subPhotoFourLink"],
      subPhotoFiveLink: json["subPhotoFiveLink"],
      placeLocation: json["placeLocation"],
      averagePlaceRating: (json["averagePlaceRating"] as num).toDouble(),
      userReview: json["userReview"] == null
          ? null
          : UserReviewModel.fromJson(json["userReview"]),
      listAllUsersReviews: (json["listAllUsersReviews"] as List)
          .map((e) => UserReviewModel.fromJson(e))
          .toList(),
      isFavorite: json["isFavorite"],
      weatherResponse: json["weatherResponse"] == null
          ? []
          : (json["weatherResponse"] as List)
          .map((e) => WeatherModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "placeId": placeId,
      "parentPlace": parentPlace,
      "mainPhotoLink": mainPhotoLink,
      "placeName": placeName,
      "quickInfo": quickInfo,
      "placeInfo": placeInfo,
      "bestSeasonToVisit": bestSeasonToVisit,
      "totalNumberOfVisitor": totalNumberOfVisitor,
      "onThisYear": onThisYear,
      "isSevenWonder": isSevenWonder,
      "subPhotoOneLink": subPhotoOneLink,
      "subPhotoTwoLink": subPhotoTwoLink,
      "subPhotoThreeLink": subPhotoThreeLink,
      "subPhotoFourLink": subPhotoFourLink,
      "subPhotoFiveLink": subPhotoFiveLink,
      "placeLocation": placeLocation,
      "averagePlaceRating": averagePlaceRating,
      "userReview": userReview?.toJson(),
      "listAllUsersReviews":
      listAllUsersReviews.map((e) => e.toJson()).toList(),
      "isFavorite": isFavorite,
      "weatherResponse":
      weatherResponse.map((e) => e.toJson()).toList(),
    };
  }
}
