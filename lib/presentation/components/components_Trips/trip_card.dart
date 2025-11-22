import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback onTap;

  const TripCard({super.key, required this.trip, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy/MM/dd - h:mm a');

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
                    trip.thumbnail,
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
                        trip.company,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Launch: ${dateFormat.format(trip.launchTime)}',
                          style: const TextStyle(color: Colors.white, fontSize: 14)),
                      Text('Return: ${dateFormat.format(trip.returnTime)}',
                          style: const TextStyle(color: Colors.white, fontSize: 14)),
                      const SizedBox(height: 6),
                      Text('${trip.from} → ${trip.to}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: trip.features
                            .map(
                              (f) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(f,
                                style: const TextStyle(color: Colors.white, fontSize: 12)),
                          ),
                        )
                            .toList(),
                      ),
                      const SizedBox(height: 6),
                      Text('Contact: ${trip.contactNumber}',
                          style: const TextStyle(color: Colors.white, fontSize: 12)),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text('${trip.price.toStringAsFixed(2)} JD',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
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
