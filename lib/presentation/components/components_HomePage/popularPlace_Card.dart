import 'package:flutter/material.dart';
/// coded by [suhaib]

class PopularCard extends StatelessWidget {
  const PopularCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> popularPlaces = [
      {
        'image':
        'https://images.unsplash.com/photo-1580834341580-8c17a3a630ca?crop=entropy&cs=srgb&fm=jpg&ixid=M3w3MjAxN3wwfDF8c2VhcmNofDN8fHBldHJhfGVufDB8fHx8MTc2MDUxNTE0MXww&ixlib=rb-4.1.0&q=85&q=85&fmt=jpg&crop=entropy&cs=tinysrgb&w=450',
        'title': 'Highest Rating',
        'rating': 4.8,
      },
      {
        'image':
        'https://images.unsplash.com/photo-1648812272958-95181f47c73e?crop=entropy&cs=srgb&fm=jpg&ixid=M3w3MjAxN3wwfDF8c2VhcmNofDZ8fGFxYWJhfGVufDB8fHx8MTc2MDUxNTkwMHww&ixlib=rb-4.1.0&q=85&q=85&fmt=jpg&crop=entropy&cs=tinysrgb&w=450',
        'title': 'Place of the week',
      },
      {
        'image':
        'https://images.unsplash.com/photo-1597424868084-872f06020714?crop=entropy&cs=srgb&fm=jpg&ixid=M3w3MjAxN3wwfDF8c2VhcmNofDN8fGplcmFzaHxlbnwwfHx8fDE3NjA1MTU0ODh8MA&ixlib=rb-4.1.0&q=85&q=85&fmt=jpg&crop=entropy&cs=tinysrgb&w=450',
        'title': 'place of the month',
      },
    ];

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: List.generate(popularPlaces.length, (index) {
              final place = popularPlaces[index];
              final bool showRating = index == 0;

              return Container(
                width: 240,
                height: 110,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(place['image']),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              place['title'],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (showRating)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.yellow.shade700,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  place['rating'].toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            ),
        );
    }
}
//coded by suhaib
