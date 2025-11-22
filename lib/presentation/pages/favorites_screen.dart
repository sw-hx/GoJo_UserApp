import 'package:flutter/material.dart';
import '../common_components/custom_returnArrow.dart';
import '../common_components/bottom_nav_bar.dart';
import '../components/components_favoritesPage/favorites_Card.dart';
import 'home_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final List<FavoritePlace> favoritePlaces = [
    FavoritePlace(
      name: 'Petra',
      imageUrl:
      'https://plus.unsplash.com/premium_photo-1674657644778-1c9f03fd1e55?crop=entropy&cs=srgb&fm=jpg&ixid=M3w3MjAxN3wwfDF8c2VhcmNofDV8fHBldHJhfGVufDB8fHx8MTc2MDUxNTE0MXww&ixlib=rb-4.1.0&q=85&q=85&fmt=jpg&crop=entropy&cs=tinysrgb&w=450',
    ),
    FavoritePlace(
      name: 'Amman',
      imageUrl:
      'https://images.unsplash.com/photo-1604510819628-539c92c78658?crop=entropy&cs=srgb&fm=jpg&ixid=M3w3MjAxN3wwfDF8c2VhcmNofDE4fHxhbW1hbnxlbnwwfHx8fDE3NjA1MTM0NDF8MA&ixlib=rb-4.1.0&q=85&q=85&fmt=jpg&crop=entropy&cs=tinysrgb&w=450',
    ),
    FavoritePlace(
      name: 'Dana Reserve',
      imageUrl:
      'https://images.unsplash.com/photo-1600945667687-b960ec00404f?crop=entropy&cs=srgb&fm=jpg&ixid=M3w3MjAxN3wwfDF8c2VhcmNofDE2fHxKZXJhc2h8ZW58MHx8fHwxNzYwNTE0MDYyfDA&ixlib=rb-4.1.0&q=85&q=85&fmt=jpg&crop=entropy&cs=tinysrgb&w=450',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomReturnArrow(targetPage: HomePage(),),
                    const SizedBox(height: 15),
                    const Text(
                      "Favorites",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF11324D),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Your journey starts here",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF11324D),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // الكاردات
                    Column(
                      children: favoritePlaces
                          .asMap()
                          .entries
                          .map(
                            (entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: FavoriteCard(
                            place: entry.value,
                            onDelete: () {
                              setState(() {
                                favoritePlaces.removeAt(entry.key);
                              });
                            },
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),

    );
    }
}
