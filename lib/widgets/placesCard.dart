import 'package:flutter/material.dart';
import 'package:go_jo_user_application/pages/placeinfo.dart';
//coded by suhaib

class PlaceCardsList extends StatelessWidget {
  const PlaceCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> places = [
      {
        'title': 'Petra',
        'desc': 'The world of the Nabataeans',
        'image':
        'https://plus.unsplash.com/premium_photo-1674657644778-1c9f03fd1e55?crop=entropy&cs=srgb&fm=jpg&ixid=M3w3MjAxN3wwfDF8c2VhcmNofDV8fHBldHJhfGVufDB8fHx8MTc2MDUxNTE0MXww&ixlib=rb-4.1.0&q=85&q=85&fmt=jpg&crop=entropy&cs=tinysrgb&w=450',
      },
      {
        'title': 'Amman',
        'desc': 'Enchanting mixture  ancient and modern',
        'image':
        'https://images.unsplash.com/photo-1604510819628-539c92c78658?crop=entropy&cs=srgb&fm=jpg&ixid=M3w3MjAxN3wwfDF8c2VhcmNofDE4fHxhbW1hbnxlbnwwfHx8fDE3NjA1MTM0NDF8MA&ixlib=rb-4.1.0&q=85&q=85&fmt=jpg&crop=entropy&cs=tinysrgb&w=450',
      },
      {
        'title': 'Irbid',
        'desc': 'Most important archeological cities',
        'image':
        'https://images.unsplash.com/photo-1600945667687-b960ec00404f?crop=entropy&cs=srgb&fm=jpg&ixid=M3w3MjAxN3wwfDF8c2VhcmNofDE2fHxKZXJhc2h8ZW58MHx8fHwxNzYwNTE0MDYyfDA&ixlib=rb-4.1.0&q=85&q=85&fmt=jpg&crop=entropy&cs=tinysrgb&w=450',
      },
      {
        'title': 'Wadi rum',
        'desc': 'The Valley of the Moon',
        'image':
        'https://images.unsplash.com/photo-1615023691139-47180d57138f?crop=entropy&cs=srgb&fm=jpg&ixid=M3w3MjAxN3wwfDF8c2VhcmNofDR8fHdhZGklMjBydW18ZW58MHx8fHwxNzYwNTE0MTAwfDA&ixlib=rb-4.1.0&q=85&q=85&fmt=jpg&crop=entropy&cs=tinysrgb&w=450',
      },
    ];

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return PlaceCard(
            title: place['title']!,
            description: place['desc']!,
            imageUrl: place['image']!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>PlaceInfo(
                    placeName: place['title']!,

                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PlaceCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback onTap;

  const PlaceCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: Container(
            width: 190,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                      size: 32,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ),
        );
    }
}
//coded by suhaib
