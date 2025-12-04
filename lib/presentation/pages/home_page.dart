import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_jo_user_application/core/constants.dart';
import 'package:go_jo_user_application/presentation/cubits/place_cubit/get_all_places_cubit/get_all_places_cubit.dart';
import 'package:go_jo_user_application/presentation/pages/profile_page.dart';

import '../../core/helpers/getUser.dart';
import '../../data/models/place_models/place_model.dart';
import '../common_components/bottom_nav_bar.dart';
import '../components/components_HomePage/places_Card.dart';
import '../components/components_HomePage/popularPlace_Card.dart';
import '../components/components_HomePage/selector_places.dart';
import 'notifications_page.dart';

/// coded by [suhaib]
class HomePage extends StatefulWidget {
  final bool showBookingConfirmation;
  const HomePage({Key? key, this.showBookingConfirmation = false}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> places = [];

  @override
  void initState() {
    super.initState();

    if (widget.showBookingConfirmation) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showTopNotification(context, "Your booking has been confirmed!");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllPlacesCubit, GetAllPlacesState>(
  listener: (context, state) {
    if(state is GetAllPlacesSuccess){
      setState(() {
        places = state.places;
      });

    }
    else if(state is GetAllPlacesFailure){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );

    }
  },
  builder: (context, state) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                            CircleAvatar(
                              child: Text(getUserData().personFullName[0].toUpperCase()),
                            ),
                          const SizedBox(width: 10),
                           Text(
                            getUserData().personFullName,
                            style: TextStyle(
                              color: Color.fromRGBO(18, 54, 69, 1),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            color: Color.fromRGBO(18, 54, 69, 1),
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationsPage(),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          right: 3,
                          top: 10,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 1,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.red, width: 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Text(
                'Discover',
                style: TextStyle(
                  color: Color.fromRGBO(18, 54, 69, 1),
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Your journey starts here',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 25),

              Container(
                height: 45,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 6),
                    ),
                  ],
                  color: Color.fromRGBO(18, 54, 69, 1),
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: const EdgeInsets.only(left: 15, right: 3),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Where to go ....',
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      width: 39,
                      height: 39,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(58, 186, 242, 1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Color.fromRGBO(18, 54, 69, 1),
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              PlacesSelector(),
              const SizedBox(height: 25),
              PlaceCardsList(places: places),
              const SizedBox(height: 15),

              const Text(
                'Popular',
                style: TextStyle(
                  color: Color.fromRGBO(18, 54, 69, 1),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              PopularCard(),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  },
);
  }
}

/// coded by [suhaib]
OverlayEntry? topNotification;

void showTopNotification(BuildContext context, String message) {
  topNotification?.remove();

  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.up,
          onDismissed: (direction) {
            hideTopNotification();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: const Color(0xFF256D85),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 28),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  topNotification = overlayEntry;

  Future.delayed(const Duration(seconds: 5), () {
    hideTopNotification();
  });
}

void hideTopNotification() {
  topNotification?.remove();
  topNotification=null;
}
