import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_jo_user_application/core/helpers/helpers.dart';
import '../../data/models/event_model.dart';
import '../../domain/repos/event_repo.dart';
import '../../services/git_it_service.dart';
import '../common_components/custom_returnArrow.dart';
import '../common_components/bottom_nav_bar.dart';
import '../components/components_eventPage/events_Card.dart';
import '../cubits/event_cubit/event_cubit.dart';
import 'home_page.dart';

/// coded by [suhaib]
class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<EventModel> events = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EventCubit(eventRepo: getIt<EventRepo>())..getEvents(),
      child: BlocConsumer<EventCubit, EventState>(
        listener: (context, state) {
          if (state is EventSuccess) {
            events = state.events;
            setState(() {});
          }
          if (state is EventError) {
            SnackBar(content: Text(state.message));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,

            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
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
                            title: formatName(event.bigTitleName),
                            time: event.timeOnly,
                            date: event.formattedDate,
                            description: event.eventInformation,
                            image: event.backgroundPictureLink,
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
        },
      ),
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
