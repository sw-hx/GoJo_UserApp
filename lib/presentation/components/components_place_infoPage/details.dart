import 'package:flutter/material.dart';

class DetailBox extends StatelessWidget {
  final String title;
  final String desc;
  final String imageUrl;

  const DetailBox({
    super.key,
    required this.title,
    required this.desc,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xff23627E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                imageUrl,
                width: 24,
                height: 24,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image_not_supported,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
