import 'package:flutter/material.dart';
import 'commentField.dart';

class CommentList extends StatelessWidget {
  final List<Map<String, String>> comments;
  final bool showAll;

  const CommentList({super.key, required this.comments, required this.showAll});

  @override
  Widget build(BuildContext context) {
    int count = showAll ? comments.length : 2;
    return SizedBox(
        height: 130,
        child: ListView.builder(
            itemCount: count,
            itemBuilder: (context, index) {
              final c = comments[index];
              return customCommentField(name: c["name"]!, comment: c["comment"]!);
            },
            ),
        );
    }
}
