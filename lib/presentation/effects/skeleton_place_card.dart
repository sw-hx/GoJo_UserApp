import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'shimmer_effect.dart';

class SkeletonPlaceCard extends StatelessWidget {
  const SkeletonPlaceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190.w,
      height: 250.h,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: const ShimmerEffect(
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
