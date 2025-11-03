import 'package:flutter/material.dart';

class DescriptionBox extends StatelessWidget {
  final String name;
  final String description;
  final bool isExpanded;
  final VoidCallback toggleExpand;

  const DescriptionBox({
    super.key,
    required this.name,
    required this.description,
    required this.isExpanded,
    required this.toggleExpand,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    Text.rich(
    maxLines: isExpanded ? null : 3,
      overflow: isExpanded ? null : TextOverflow.ellipsis,
      TextSpan(children: [
        TextSpan(text: "$name ", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 25)),
        TextSpan(text: description, style: const TextStyle(color: Colors.black87, fontSize: 16)),
      ]),
    ),
    GestureDetector(
    onTap: toggleExpand,
    child: Text(isExpanded ? 'Read Less' : 'Read More', textAlign: TextAlign.center, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15)),
    ),
    ],
    );
    }
}
