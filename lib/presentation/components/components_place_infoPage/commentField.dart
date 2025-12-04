import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../../data/models/review_model.dart';


class CommentField extends StatelessWidget {
  final UserReviewModel review;

  const CommentField({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.blueGrey,
                child: review.profilePhoto == null
                    ? const Icon(Icons.person, color: Colors.white)
                    : ClipOval(
                  child: Image.network(
                    review.profilePhoto!,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  review.userOwnReview,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RatingBarIndicator(
            rating: review.rating.toDouble(),
            itemCount: 5,
            itemSize: 22,
            itemBuilder: (context, _) =>
            const Icon(Icons.star, color: Colors.amber),
          ),
          const SizedBox(height: 6),
          Text(
            review.review,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 6),
          Text(
            DateFormat('yyyy-MM-dd').format(review.createdAt),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
