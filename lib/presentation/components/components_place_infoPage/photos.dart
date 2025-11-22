import 'package:flutter/material.dart';

class PhotoBox extends StatelessWidget {
  final String url;

  const PhotoBox({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 20),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(url, width: 170, height: 250, fit: BoxFit.cover),
            ),
        );
    }
}