import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_jo_user_application/data/models/review_model.dart';
import 'commentField.dart';

class CommentList extends StatelessWidget {
  final List<UserReviewModel> comments;
  final bool showAll;

  const CommentList({super.key, required this.comments, required this.showAll});

  @override
  Widget build(BuildContext context) {
    int count = showAll ? comments.length : min(2, comments.length);

    return SizedBox(
      height: 130,
      child: ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) {
          final c = comments[index];
          return customCommentField(
            name: c.userOwnReview,
            comment: c.review,
          );
        },
      ),
    );
  }
}
