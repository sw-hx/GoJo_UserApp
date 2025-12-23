import 'package:flutter/material.dart';
import 'shimmer_effect.dart';

class SkeletonPupolerCard extends StatelessWidget {
  const SkeletonPupolerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 250,
      margin: const EdgeInsets.only(right: 12),
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