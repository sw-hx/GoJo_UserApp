import 'package:flutter/material.dart';
import 'package:go_jo_user_application/data/models/trip_model.dart';
import 'package:intl/intl.dart';

import '../../../core/helpers/helpers.dart';

class TripCard extends StatelessWidget {
  final TripModel trip;
  final VoidCallback onTap;

  const TripCard({super.key, required this.trip, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy/MM/dd - h:mm a');

    final launch = DateTime.parse(
      "${trip.lunchDate ?? "2000-01-01"} ${trip.lunchHour ?? "00:00:00"}",
    );

    final returnTime = DateTime.parse(
      "${trip.returnDate ?? "2000-01-01"} ${trip.returnHour ?? "00:00:00"}",
    );

    final thumbnail = trip.tripPhotoOneLink ??
        trip.tripPhotoTwoLink ??
        trip.tripPhotoThreeLink ??
        "https://via.placeholder.com/150";

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF307896),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                thumbnail,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatPlace(trip.companyOwnTrip),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    'Launch: ${dateFormat.format(launch)}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    'Return: ${dateFormat.format(returnTime)}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),

                  const SizedBox(height: 6),
                  Text(
                    '${formatPlace(trip.tripLunchPlace)} → ${formatPlace(trip.placeName)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: (trip.tripFeatures ?? [])
                        .map(
                          (f) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          f,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                    )
                        .toList(),
                  ),

                  const SizedBox(height: 6),
                  Text(
                    'Contact: ${trip.contactPhoneNumber ?? ""}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),

                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '${(trip.price ?? 0).toStringAsFixed(2)} JD',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
