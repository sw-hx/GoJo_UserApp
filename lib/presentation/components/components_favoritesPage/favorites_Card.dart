import 'package:flutter/material.dart';

import '../../../data/models/favorite_model.dart';


class FavoriteCard extends StatelessWidget {
  final FavoriteModel place;
  final VoidCallback? onDelete;

  const FavoriteCard({super.key, required this.place, this.onDelete});

  @override
  Widget build(BuildContext context) {
    const double cardHeight = 130;
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: 400,
              height: cardHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  children: [
                    Image.network(
                      place.placeMainPhotoUrl,
                      width: 400,
                      height: cardHeight,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: 400,
                      height: cardHeight,
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
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        place.placeName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          shadows: [
                            Shadow(
                              blurRadius: 5,
                              color: Colors.black45,
                              offset: Offset(1, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: GestureDetector(
                        onTap: onDelete,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.delete,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
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
