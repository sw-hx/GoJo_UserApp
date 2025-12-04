import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_jo_user_application/core/helpers/helpers.dart';
import 'package:go_jo_user_application/data/models/trip_model.dart';
import 'package:go_jo_user_application/presentation/cubits/trip_cubit/get_trips_by_place_id_cubit.dart';
import 'package:intl/intl.dart';
import '../common_components/custom_returnArrow.dart';
import '../common_components/bottom_nav_bar.dart';
import '../components/components_Trips/sort_button.dart';
import '../components/components_Trips/trip_card.dart';
import 'booking_page.dart';
import 'place_info_screen.dart';
import '../cubits/place_cubit/get_place_info_cubit/get_place_info_cubit.dart';

class TripsCardPage extends StatefulWidget {
  const TripsCardPage({super.key});

  @override
  State<TripsCardPage> createState() => _TripsCardPageState();
}

class _TripsCardPageState extends State<TripsCardPage> {
  List<TripModel> trips = [];
  String? sortType;

  @override
  void initState() {
    super.initState();
  }

  void sortTrips(String type) {
    setState(() {
      sortType = type;

      if (type == 'Lowest Price') {
        trips.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
      } else if (type == 'Highest Price') {
        trips.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
      } else if (type == 'Earliest Launch') {
        trips.sort((a, b) => _date(a).compareTo(_date(b)));
      } else if (type == 'Latest Launch') {
        trips.sort((a, b) => _date(b).compareTo(_date(a)));
      }
    });
  }

  DateTime _date(TripModel t) {
    return DateTime.parse("${t.lunchDate ?? "2000-01-01"} ${t.lunchHour ?? "00:00:00"}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetTripsByPlaceIdCubit, GetTripsByPlaceIdState>(
      listener: (context, state) {
        if (state is GetTripsByPlaceIdSuccess) {
          setState(() {
            trips = state.trips;
          });
        }
        if (state is GetTripsByPlaceIdFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
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
                  const SizedBox(height: 20),
                  SortButton(selectedSort: sortType, onSelect: sortTrips),
                  const SizedBox(height: 20),

                  if (state is GetTripsByPlaceIdLoading)
                    const Center(child: CircularProgressIndicator()),

                  if (state is GetTripsByPlaceIdSuccess)
                    Column(
                      children: trips.map((trip) {
                        final launch = _date(trip);
                        final returnTime =
                        DateTime.parse("${trip.returnDate ?? "2000-01-01"} ${trip.returnHour ?? "00:00:00"}");

                        return TripCard(
                          trip: trip,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BookingPage(
                                  companyName: formatPlace(trip.companyOwnTrip),
                                  rating: 4,
                                  launchDate: DateFormat('yyyy/MM/dd - h:mm a').format(launch),
                                  returnDate: DateFormat('yyyy/MM/dd - h:mm a').format(returnTime),
                                  fromLocation: formatPlace(trip.tripLunchPlace),
                                  toLocation: formatPlace(trip.placeName),
                                  contactNumber: trip.contactPhoneNumber ?? "",
                                  details: trip.tripDetail ?? "",
                                  features: trip.tripFeatures ?? [],
                                  galleryImages: [
                                    trip.tripPhotoOneLink ?? "",
                                    trip.tripPhotoTwoLink ?? "",
                                    trip.tripPhotoThreeLink ?? "",
                                  ],
                                  price: trip.price ?? 0,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
