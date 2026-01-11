import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:go_jo_user_application/presentation/cubits/get_booked_trip_cubit/get_booked_trip_cubit.dart';
import '../../core/theme.dart';
import '../../data/models/trip_model.dart';
import '../../domain/repos/checkout_repo.dart';
import '../../domain/repos/trip_repo.dart';
import '../../services/git_it_service.dart';
import '../common_components/bottom_nav_bar.dart';
import '../components/components_Trips/trip_card.dart';
import '../cubits/payment_cubits/checkout_cubit/checkout_cubit.dart';
import '../cubits/user_book_trip_cubit/user_book_trip_cubit.dart';
import 'booking_page.dart';

class BookedTripsPage extends StatefulWidget {
  const BookedTripsPage({super.key});

  @override
  State<BookedTripsPage> createState() => _BookedTripsPageState();
}

class _BookedTripsPageState extends State<BookedTripsPage> {
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
        child: Padding(
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
              Expanded(
                child: BlocBuilder<GetBookedTripCubit, GetBookedTripState>(
                  builder: (context, state) {
                    if (state is GetBookedTripLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is GetBookedTripEmpty) {
                      return const Center(
                        child: Text(
                          "You haven't booked any trips yet",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }

                    if (state is GetBookedTripFailure) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (state is GetBookedTripSuccess) {
                      return ListView.builder(
                        itemCount: state.trips.length,
                        itemBuilder: (context, index) {
                          final trip = state.trips[index];

                          return TripCard(
                            trip: trip,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      MultiBlocProvider(
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
                                          tripId: trip.tripId ?? 0,
                                          companyName:
                                          trip.companyOwnTrip ?? "",
                                          rating: 4,
                                          launchDate: DateFormat(
                                              'yyyy/MM/dd - h:mm a')
                                              .format(_launchDate(trip)),
                                          returnDate: DateFormat(
                                              'yyyy/MM/dd - h:mm a')
                                              .format(_returnDate(trip)),
                                          fromLocation:
                                          trip.tripLunchPlace ?? "",
                                          toLocation: trip.placeName ?? "",
                                          contactNumber:
                                          trip.contactPhoneNumber ?? "",
                                          details: trip.tripDetail ?? "",
                                          features: trip.tripFeatures ?? [],
                                          galleryImages: [
                                            trip.tripPhotoOneLink ?? "",
                                            trip.tripPhotoTwoLink ?? "",
                                            trip.tripPhotoThreeLink ?? "",
                                          ],
                                          price: trip.price ?? 0,
                                          showBookNow: false,
                                          location: trip.tripLunchLocation ??
                                              "",
                                        ),
                                      ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}
