import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/theme.dart';
import '../../data/models/trip_model.dart';
import '../common_components/bottom_nav_bar.dart';
import '../components/components_Trips/trip_card.dart';
import 'booking_page.dart';

/// coded by [suhaib]

class BookedTripsPage extends StatefulWidget {
  const BookedTripsPage({super.key});

  @override
  State<BookedTripsPage> createState() => _BookedTripsPageState();
}

class _BookedTripsPageState extends State<BookedTripsPage> {
  final List<TripModel> bookedTrips = [
    TripModel(
      companyOwnTrip: "GOJO Travel",
      tripLunchPlace: "Amman",
      placeName: "Petra",
      lunchDate: "2025-01-20",
      lunchHour: "08:00:00",
      returnDate: "2025-01-20",
      returnHour: "20:00:00",
      price: 45,
      contactPhoneNumber: "0799999999",
      tripDetail: "One day adventure to Petra",
      tripFeatures: ["Guide", "Bus", "Lunch"],
      tripPhotoOneLink:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCrxKwYkErVB1pSvhWq0AKyAgzKYadJMkT4Q&s",
      tripPhotoTwoLink:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCrxKwYkErVB1pSvhWq0AKyAgzKYadJMkT4Q&s",
      tripPhotoThreeLink:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCrxKwYkErVB1pSvhWq0AKyAgzKYadJMkT4Q&s",
    ),
  ];

  DateTime _launchDate(TripModel t) {
    return DateTime.parse(
      "${t.lunchDate ?? "2000-01-01"} ${t.lunchHour ?? "00:00:00"}",
    );
  }

  DateTime _returnDate(TripModel t) {
    return DateTime.parse(
      "${t.returnDate ?? "2000-01-01"} ${t.returnHour ?? "00:00:00"}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultTheme.colorWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              const Text(
                "Booked Trips",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF11324D),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Your confirmed journeys",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF11324D),
                ),
              ),
              const SizedBox(height: 25),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bookedTrips.length,
                itemBuilder: (context, index) {
                  final trip = bookedTrips[index];

                  return TripCard(
                    trip: trip,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookingPage(
                            tripId: 1,
                            companyName: trip.companyOwnTrip ?? "",
                            rating: 4,
                            launchDate: DateFormat('yyyy/MM/dd - h:mm a')
                                .format(_launchDate(trip)),
                            returnDate: DateFormat('yyyy/MM/dd - h:mm a')
                                .format(_returnDate(trip)),
                            fromLocation:
                            trip.tripLunchPlace ?? "",
                            toLocation:
                            trip.placeName ?? "",
                            contactNumber:
                            trip.contactPhoneNumber ?? "",
                            details:
                            trip.tripDetail ?? "",
                            features:
                            trip.tripFeatures ?? [],
                            galleryImages: [
                              trip.tripPhotoOneLink ?? "",
                              trip.tripPhotoTwoLink ?? "",
                              trip.tripPhotoThreeLink ?? "",
                            ],
                            price: trip.price ?? 0,

                            showBookNow: false,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}
