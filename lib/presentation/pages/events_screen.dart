import 'package:flutter/material.dart';
import '../common_components/custom_returnArrow.dart';
import '../common_components/bottom_nav_bar.dart';
import '../components/components_eventPage/events_Card.dart';
import 'home_page.dart';

/// coded by [suhaib]
class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  final List<Event> events = const [
    Event(
      title: "Children's Museum",
      time: "7:30 pm",
      date: "11/11",
      description:
      "There will be an event at the Children's Museum where a group of content creators will attend and do beautiful and wonderful activities.",
      image:
      "https://cmj.jo/wp-content/uploads/2021/03/FB_IMG_1568119772792-872x600.jpg",
    ),
    Event(
      title: "Aqaba",
      time: "5:00 pm",
      date: "22/11",
      description:
      "Join us in Aqaba for a seaside cultural event featuring music, food, and art from across Jordan.",
      image:
      "https://i0.wp.com/www.touristisrael.com/wp-content/uploads/2013/09/aqaba-red-sea-nature-scaled.jpg?fit=2560%2C1707&ssl=1",
    ),
    Event(
      title: "Amman Run",
      time: "8:00 pm",
      date: "28/11",
      description:
      "Experience the Amman Citadel Festival, a celebration of heritage, art, and community in the heart of Jordan.",
      image: "https://jordantimes.com/uploads/imported_images/files/marathon.png",
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomReturnArrow(targetPage: HomePage()),
                  const SizedBox(height: 20),
                  const Text(
                    "Events",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF11324D),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Your journey starts here",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF11324D),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),

                  ...events.map((event) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: EventCard(
                        title: event.title,
                        time: event.time,
                        date: event.date,
                        description: event.description,
                        image: event.image,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 2),
        );
    }
}

class Event {
  final String title;
  final String time;
  final String date;
  final String description;
  final String image;

  const Event({
    required this.title,
    required this.time,
    required this.date,
    required this.description,
    required this.image,
  });

}
