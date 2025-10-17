import 'package:flutter/material.dart';
import 'package:go_jo_user_application/pages/notifications_page.dart';
import 'package:go_jo_user_application/pages/profile_page.dart';
import 'package:go_jo_user_application/widgets/bottom_nav_bar.dart';
import 'package:go_jo_user_application/widgets/places.dart';
import 'package:go_jo_user_application/widgets/placesCard.dart';
import 'package:go_jo_user_application/widgets/popularPlaceCard.dart';

/// coded by [suhaib]
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    //عشان يخلي الاسم والصوره للانتقال لصفحه ال profile
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
                          ClipOval(
                            child: Image.network(
                              'https://cdn.racingnews365.com/2025/Hamilton/_1092x683_crop_center-center_85_none/XPB_1358753_HiRes.jpg?v=1752766813',
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Suhaib Samaneh',
                            style: TextStyle(
                              color: Color.fromRGBO(18, 54, 69, 1),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(), //space
                    // الاشعارات
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            color: Color.fromRGBO(18, 54, 69, 1),
                            size: 45,
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
                          right: 10,
                          top: 10,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5,
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

              // Discover title
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

              //search baaaar مع ظل
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
                    //شكل الsearch
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
              //////////////////////////////////
              const SizedBox(height: 25),
              PlaceCardsList(),
              /////////////////////////////////
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

      ///////////////////////////////////////////////////
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}

//coded by suhaib
