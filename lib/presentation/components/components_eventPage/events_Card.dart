import 'package:flutter/material.dart';
/// coded by [suhaib]

class EventCard extends StatelessWidget {
  final String title;
  final String time;
  final String date;
  final String description;
  final String image;

  const EventCard({
    super.key,
    required this.title,
    required this.time,
    required this.date,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: [
                    Image.network(
                      image,
                      width: 400,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: 400,
                      height: 250,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 2),
                                  blurRadius: 4,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  time,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1, 1),
                                        blurRadius: 4,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  date,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1, 1),
                                        blurRadius: 4,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  description,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1, 1),
                                        blurRadius: 4,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ),
        );
    }
}
