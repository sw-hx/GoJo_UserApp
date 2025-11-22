import 'package:flutter/material.dart';

class SortButton extends StatelessWidget {
  final String? selectedSort;
  final Function(String) onSelect;

  const SortButton({super.key, required this.selectedSort, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                  builder: (context) {
                    List<String> options = [
                      'Lowest Price',
                      'Highest Price',
                      'Earliest Launch',
                      'Latest Launch',
                    ];
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Sort Trips By',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          for (var option in options)
                            ListTile(
                              title: Text(option),
                              trailing: option == selectedSort
                                  ? const Icon(Icons.check, color: Color(0xFF307896))
                                  : null,
                              onTap: () {
                                onSelect(option);
                                Navigator.pop(context);
                              },
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF307896),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3))
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.sort, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      selectedSort ?? 'Sort',
                      style: const TextStyle(
                          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            ),
        );
    }
}
