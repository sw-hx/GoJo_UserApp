import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_jo_user_application/presentation/components/components_place_infoPage/place_data.dart';

class RatingWidget extends StatelessWidget {
  final PlaceData place;

  const RatingWidget({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      RatingBarIndicator(
      rating: place.rating,
      itemCount: 5,
      itemSize: 30,
      unratedColor: Colors.grey.shade300,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
    ),
    const SizedBox(width: 8),
    Container(
    width: 45,
    height: 45,
    decoration: const BoxDecoration(
    color: Color(0xFFFFC107),
    shape: BoxShape.circle,
    ),
    alignment: Alignment.center,
    child: Text(
    place.rating.toStringAsFixed(1),
    style: const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 18,
    ),
    ),
    ),
    ],
    );
    }
}
