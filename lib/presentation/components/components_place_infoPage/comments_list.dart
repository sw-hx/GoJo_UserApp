import 'package:flutter/material.dart';
import '../../../data/models/review_model.dart';
import 'commentField.dart';

class CommentList extends StatelessWidget {
  final List<UserReviewModel> comments;
  final bool showAll;

  const CommentList({
    super.key,
    required this.comments,
    required this.showAll,
  });

  @override
  Widget build(BuildContext context) {
    int count = showAll ? comments.length : (comments.length >= 2 ? 2 : comments.length);

    if (comments.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "No comments yet",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      children: List.generate(
        count,
            (index) => CommentField(review: comments[index]),
      ),
    );
  }
}
