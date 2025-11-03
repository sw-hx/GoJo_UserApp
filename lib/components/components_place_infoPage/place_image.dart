import 'package:flutter/material.dart';

class PlaceImage extends StatelessWidget {
  final String imageUrl;
  final String name;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const PlaceImage({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.bottomCenter,
        children: [
    ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Image.network(imageUrl, height: 120, width: double.infinity, fit: BoxFit.cover),
    ),
    Text(name, textAlign: TextAlign.center, style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white, shadows: [Shadow(blurRadius: 8, color: Colors.black54, offset: Offset(2, 2))])),
    Positioned(
    top: 10,
    right: 10,
    child: GestureDetector(
    onTap: onFavoriteTap,
    child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : Colors.white, size: 32),
    ),
    ),
    ],
    );
    }
}
