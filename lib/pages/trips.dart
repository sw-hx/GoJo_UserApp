import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common_components/custom_returnArrow.dart';
import '../common_components/bottom_nav_bar.dart';
import '../components/components_Trips/models.dart';
import '../components/components_Trips/sort_button.dart';
import '../components/components_Trips/trip_card.dart';
import 'booking_page.dart';
import 'place_info_screen.dart';

class TripsCardPage extends StatefulWidget {
  const TripsCardPage({super.key});

  @override
  State<TripsCardPage> createState() => _TripsCardPageState();
}

class _TripsCardPageState extends State<TripsCardPage> {
  List<Trip> trips = [
    Trip(
      company: "Petra Ride Company",
      launchTime: DateTime(2025, 11, 19, 7, 30),
      returnTime: DateTime(2025, 11, 19, 20, 30),
      price: 20.99,
      from: "Amman",
      to: "Petra",
      contactNumber: "00962787498076",
      details:
      "Explore the Siq and the Treasury, walking through the narrow canyon and capturing stunning photos. Visit historical landmarks like the Roman Theater, Royal Tombs, and Colonnaded Street.",
      features: ["Air conditioning", "Lunch", "Comfortable chairs", "Tour guide"],
      galleryImages: [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKYY_HMrttR9FYDV9wTc85VZjSoAkcg1CMzA&s",
        "https://wp.expatexplore.com/wp-content/uploads/2015/06/current-branding-Coach-and-Group.jpg",
        "https://wildlandtrekking.com/content/uploads/2021/08/guidedgroup-1200x901.jpg",
      ],
      thumbnail: "https://wp.expatexplore.com/wp-content/uploads/2015/06/current-branding-Coach-and-Group.jpg",
    ),
    Trip(
      company: "New Land Company",
      launchTime: DateTime(2025, 11, 19, 12, 0),
      returnTime: DateTime(2025, 11, 19, 20, 0),
      price: 23.99,
      from: "Zarqa",
      to: "Petra",
      contactNumber: "00962798765432",
      details: "Experience the magic of Petra with professional guides and a comfortable bus. Lunch and refreshments included.",
      features: ["Lunch", "Wi-Fi", "Tour guide", "Photo stops"],
      galleryImages: [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKYY_HMrttR9FYDV9wTc85VZjSoAkcg1CMzA&s",
        "https://wp.expatexplore.com/wp-content/uploads/2015/06/current-branding-Coach-and-Group.jpg",
        "https://wildlandtrekking.com/content/uploads/2021/08/guidedgroup-1200x901.jpg",
      ],
      thumbnail: "https://wp.expatexplore.com/wp-content/uploads/2015/06/current-branding-Coach-and-Group.jpg",
    ),
    Trip(
      company: "Jenny Company",
      launchTime: DateTime(2025, 11, 20, 7, 30),
      returnTime: DateTime(2025, 11, 21, 0, 0),
      price: 40.0,
      from: "Irbid",
      to: "Petra",
      contactNumber: "00962791234567",
      details: "Enjoy a premium overnight trip to Petra with a night tour and luxury buses.",
      features: ["Night tour", "Luxury bus", "Snacks", "Wi-Fi"],
      galleryImages: [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKYY_HMrttR9FYDV9wTc85VZjSoAkcg1CMzA&s",
        "https://wp.expatexplore.com/wp-content/uploads/2015/06/current-branding-Coach-and-Group.jpg",
        "https://wildlandtrekking.com/content/uploads/2021/08/guidedgroup-1200x901.jpg",
      ],
      thumbnail: "https://wp.expatexplore.com/wp-content/uploads/2015/06/current-branding-Coach-and-Group.jpg",
    ),
    Trip(
      company: "Sam Company",
      launchTime: DateTime(2025, 11, 19, 7, 0),
      returnTime: DateTime(2025, 11, 19, 20, 30),
      price: 15.0,
      from: "Aqaba",
      to: "Petra",
      contactNumber: "00962795554411",
      details: "A one-day affordable trip from Aqaba to Petra, great for small groups and families.",
      features: ["Affordable", "Tour guide", "Snacks"],
      galleryImages: [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKYY_HMrttR9FYDV9wTc85VZjSoAkcg1CMzA&s",
        "https://wp.expatexplore.com/wp-content/uploads/2015/06/current-branding-Coach-and-Group.jpg",
        "https://wildlandtrekking.com/content/uploads/2021/08/guidedgroup-1200x901.jpg",
      ],
      thumbnail: "https://wp.expatexplore.com/wp-content/uploads/2015/06/current-branding-Coach-and-Group.jpg",
    ),
    Trip(
        company: "Jet Company",
        launchTime: DateTime(2025, 11, 25, 12, 10),
        returnTime: DateTime(2025, 11, 25, 20, 30),
        price: 14.99,
        from: "Amman",
        to: "Petra",
        contactNumber: "00962790001234",
        details: "Enjoy a smooth ride with Jet Company’s new fleet of buses. Refreshments and free Wi-Fi onboard.",
        features: ["Free Wi-Fi", "Snacks", "Air conditioning"],
        galleryImages: [
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKYY_HMrttR9FYDV9wTc85VZjSoAkcg1CMzA&s",
          "https://wp.expatexplore.com/wp-content/uploads/2015/06/current-branding-Coach-and-Group.jpg",
          "https://wildlandtrekking.com/content/uploads/2021/08/guidedgroup-1200x901.jpg",
        ],
        thumbnail: "https://wp.expatexplore.com/wp-content/uploads/2015/06/current-branding-Coach-and-Group.jpg",
        ),
  ];

  String? sortType;

  void sortTrips(String type) {
    setState(() {
      sortType = type;
      if (type == 'Lowest Price') {
        trips.sort((a, b) => a.price.compareTo(b.price));
      } else if (type == 'Highest Price') {
        trips.sort((a, b) => b.price.compareTo(a.price));
      } else if (type == 'Earliest Launch') {
        trips.sort((a, b) => a.launchTime.compareTo(b.launchTime));
      } else if (type == 'Latest Launch') {
        trips.sort((a, b) => b.launchTime.compareTo(a.launchTime));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomReturnArrow(targetPage: PlaceInfoScreen()),
                const SizedBox(height: 30),
                const Text("Available Trips",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF11324D))),
                const SizedBox(height: 8),
                const Text("Your journey starts here",
                    style: TextStyle(fontSize: 16, color: Color(0xFF11324D))),
                /////////////////////////////////
                const SizedBox(height: 20),
                SortButton(selectedSort: sortType, onSelect: (value) => sortTrips(value)),
                ////////////////////////////////
                const SizedBox(height: 20),
                /////////////////////////////////
                for (var trip in trips)
                  TripCard(
                    trip: trip,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingPage(
                            companyName: trip.company,
                            rating: 4,
                            launchDate: DateFormat('yyyy/MM/dd - h:mm a').format(trip.launchTime),
                            returnDate: DateFormat('yyyy/MM/dd - h:mm a').format(trip.returnTime),
                            fromLocation: trip.from,
                            toLocation: trip.to,
                            contactNumber: trip.contactNumber,
                            details: trip.details,
                            features: trip.features,
                            galleryImages: trip.galleryImages,
                            price: trip.price,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
        );
    }
}
