import 'package:flutter/material.dart';
import 'shimmer_effect.dart';

class SkeletonPopularCard extends StatelessWidget {
  const SkeletonPopularCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 110,
      margin: const EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: const ShimmerEffect(
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
