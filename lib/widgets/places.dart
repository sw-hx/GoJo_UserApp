import 'package:flutter/material.dart';
//coded by suhaib

class PlacesSelector extends StatefulWidget {
  const PlacesSelector({super.key});

  @override
  State<PlacesSelector> createState() => placesSelector();
}

class placesSelector extends State<PlacesSelector> {
  final List<String> categories = [
    'All',
    'Petra',
    'Wadi Rum',
    'Dead Sea',
    'Amman',
  ];

  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: 10), //مساحه بين كل عنصر
        itemBuilder: (context, index) {
          final category = categories[index];
          final selected = category == selectedCategory;

          return GestureDetector(
            onTap: () => setState(() {
              selectedCategory = category;
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
              decoration: BoxDecoration(
                color: selected
                    ? const Color.fromRGBO(53, 159, 205, 1)
                    : const Color.fromRGBO(217, 217, 217, 1),
                borderRadius: BorderRadius.circular(7676),
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//coded by suhaib
