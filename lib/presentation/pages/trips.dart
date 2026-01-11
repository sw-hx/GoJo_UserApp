import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_jo_user_application/core/helpers/helpers.dart';
import 'package:go_jo_user_application/data/models/trip_model.dart';
import 'package:go_jo_user_application/presentation/cubits/trip_cubit/get_trips_by_place_id_cubit.dart';
import 'package:intl/intl.dart';
import '../../domain/repos/checkout_repo.dart';
import '../../domain/repos/trip_repo.dart';
import '../../services/git_it_service.dart';
import '../common_components/custom_returnArrow.dart';
import '../common_components/bottom_nav_bar.dart';
import '../components/components_Trips/sort_button.dart';
import '../components/components_Trips/trip_card.dart';
import '../cubits/payment_cubits/checkout_cubit/checkout_cubit.dart';
import '../cubits/user_book_trip_cubit/user_book_trip_cubit.dart';
import 'booking_page.dart';
import 'place_info_screen.dart';

class TripsCardPage extends StatefulWidget {
  const TripsCardPage({super.key});

  @override
  State<TripsCardPage> createState() => _TripsCardPageState();
}

class _TripsCardPageState extends State<TripsCardPage> {
  List<TripModel> trips = [];
  String? sortType;

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
    return DateTime.parse(
      "${t.lunchDate ?? "2000-01-01"} ${t.lunchHour ?? "00:00:00"}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTripsByPlaceIdCubit, GetTripsByPlaceIdState>(
      builder: (context, state) {
        if (state is GetTripsByPlaceIdSuccess) {
          trips = state.trips;
        }

        if (state is GetTripsByPlaceIdFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          });
        }

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomReturnArrow(targetPage: PlaceInfoScreen()),
                  const SizedBox(height: 30),

                  const Text(
                    "Available Trips",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF11324D),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Your journey starts here",
                    style: TextStyle(fontSize: 16, color: Color(0xFF11324D)),
                  ),

                  const SizedBox(height: 20),

                  SortButton(selectedSort: sortType, onSelect: sortTrips),

                  const SizedBox(height: 20),

                  if (state is GetTripsByPlaceIdLoading)
                    const Center(child: CircularProgressIndicator()),

                  if (state is GetTripsByPlaceIdSuccess)
                    if (trips.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 60),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF11324D,
                                  ).withOpacity(0.08),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.travel_explore,
                                  size: 64,
                                  color: Color(0xFF11324D),
                                ),
                              ),

                              const SizedBox(height: 24),

                              const Text(
                                "No Trips Available",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF11324D),
                                ),
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                "Check back later or explore another destination",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                  Column(
                    children: trips.map((trip) {
                      final launch = _date(trip);
                      final returnTime = DateTime.parse(
                        "${trip.returnDate ?? "2000-01-01"} ${trip.returnHour ?? "00:00:00"}",
                      );

                      return TripCard(
                        trip: trip,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) => CheckoutCubit(
                                      checkoutRepo: getIt.get<CheckoutRepo>(),
                                    ),
                                  ),
                                  BlocProvider(
                                     create: (context) =>
                                       UserBookTripCubit(
                                          tripRepo: getIt<TripRepo>(),
                                  ),
                                  )
                                ],
                                child: BookingPage(
                                  tripId: trip.tripId!,
                                  companyName: formatName(trip.companyOwnTrip),
                                  rating: 4,
                                  launchDate: DateFormat(
                                    'yyyy/MM/dd - h:mm a',
                                  ).format(launch),
                                  returnDate: DateFormat(
                                    'yyyy/MM/dd - h:mm a',
                                  ).format(returnTime),
                                  fromLocation: formatName(trip.tripLunchPlace),
                                  toLocation: formatName(trip.placeName),
                                  contactNumber: trip.contactPhoneNumber ?? "",
                                  details: trip.tripDetail ?? "",
                                  features: trip.tripFeatures ?? [],
                                  galleryImages: [
                                    trip.tripPhotoOneLink ?? "",
                                    trip.tripPhotoTwoLink ?? "",
                                    trip.tripPhotoThreeLink ?? "",
                                  ],
                                  price: trip.price ?? 0,
                                  location: trip.tripLunchLocation,
                                  showBookNow:
                                      !(trip.isUserBookedTrip ?? false),
                                ),
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
