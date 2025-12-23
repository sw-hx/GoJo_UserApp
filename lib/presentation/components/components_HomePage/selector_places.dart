import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../cubits/place_cubit/get_places_by_parentPlace/get_places_by_parent_place_cubit.dart';

/// coded by [suhaib]

class PlacesSelector extends StatefulWidget {
  const PlacesSelector({super.key});

  @override
  State<PlacesSelector> createState() => _PlacesSelectorState();
}

class _PlacesSelectorState extends State<PlacesSelector> {
  final List<String> categories = [
    'All',
    "Amman",
    "Zarqa",
    "Irbid",
    "Aqaba",
    "Salt",
    "Madaba",
    "Mafraq",
    "Jerash",
    "Ajloun",
    "Karak",
    "Tafilah",
    "Maan",
  ];

  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = categories[index];
          final bool selected = category == selectedCategory;

          return _CategoryChip(
            category: category,
            selected: selected,
            index: index,
            onTap: () {
              setState(() => selectedCategory = category);
              context
                  .read<GetPlacesByParentPlaceCubit>()
                  .getPlacesByParentPlace(category);
            },
          );
        },
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.2);
  }
}

class _CategoryChip extends StatefulWidget {
  final String category;
  final bool selected;
  final VoidCallback onTap;
  final int index;

  const _CategoryChip({
    required this.category,
    required this.selected,
    required this.onTap,
    required this.index,
  });

  @override
  State<_CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<_CategoryChip> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.94),
      onTapUp: (_) => setState(() => scale = 1),
      onTapCancel: () => setState(() => scale = 1),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: widget.selected ? 30 : 25,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: widget.selected
                ? const Color.fromRGBO(53, 159, 205, 1)
                : const Color.fromRGBO(217, 217, 217, 1),
            borderRadius: BorderRadius.circular(100),
            boxShadow: widget.selected
                ? [] : [],
          ),
          child: Text(
            widget.category,
            style: TextStyle(
              color: widget.selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    )
        .animate(delay: (widget.index * 80).ms)
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.3)
        .animate(target: widget.selected ? 1 : 0)
        .scale(
      begin: const Offset(1, 1),
      end: const Offset(1.08, 1.08),
      curve: Curves.easeOutBack,
    );
  }
}
