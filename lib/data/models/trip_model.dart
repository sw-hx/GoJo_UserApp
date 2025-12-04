class TripModel {
  final int? tripId;
  final String? companyOwnTrip;
  final String? placeName;
  final String? tripLunchPlace;
  final String? lunchDate;
  final String? lunchHour;
  final String? returnDate;
  final String? returnHour;
  final String? contactPhoneNumber;
  final String? tripDetail;
  final String? tripPhotoOneLink;
  final String? tripPhotoTwoLink;
  final String? tripPhotoThreeLink;
  final double? price;
  final String? tripLunchLocation;
  final List<String>? tripFeatures;

  TripModel({
    this.tripId,
    this.companyOwnTrip,
    this.placeName,
    this.tripLunchPlace,
    this.lunchDate,
    this.lunchHour,
    this.returnDate,
    this.returnHour,
    this.contactPhoneNumber,
    this.tripDetail,
    this.tripPhotoOneLink,
    this.tripPhotoTwoLink,
    this.tripPhotoThreeLink,
    this.price,
    this.tripLunchLocation,
    this.tripFeatures,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      tripId: json["tripId"],
      companyOwnTrip: json["companyOwnTrip"],
      placeName: json["placeName"],
      tripLunchPlace: json["tripLunchPlace"],
      lunchDate: json["lunchDate"],
      lunchHour: json["lunchHour"],
      returnDate: json["returnDate"],
      returnHour: json["returnHour"],
      contactPhoneNumber: json["contactPhoneNumber"],
      tripDetail: json["tripDetail"],
      tripPhotoOneLink: json["tripPhotoOneLink"],
      tripPhotoTwoLink: json["tripPhotoTwoLink"],
      tripPhotoThreeLink: json["tripPhotoThreeLink"],
      price: (json["price"] as num?)?.toDouble(),
      tripLunchLocation: json["tripLunchLocation"],
      tripFeatures: json["tripFeatures"] != null
          ? List<String>.from(json["tripFeatures"])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "tripId": tripId,
      "companyOwnTrip": companyOwnTrip,
      "placeName": placeName,
      "tripLunchPlace": tripLunchPlace,
      "lunchDate": lunchDate,
      "lunchHour": lunchHour,
      "returnDate": returnDate,
      "returnHour": returnHour,
      "contactPhoneNumber": contactPhoneNumber,
      "tripDetail": tripDetail,
      "tripPhotoOneLink": tripPhotoOneLink,
      "tripPhotoTwoLink": tripPhotoTwoLink,
      "tripPhotoThreeLink": tripPhotoThreeLink,
      "price": price,
      "tripLunchLocation": tripLunchLocation,
      "tripFeatures": tripFeatures,
    };
  }
}
