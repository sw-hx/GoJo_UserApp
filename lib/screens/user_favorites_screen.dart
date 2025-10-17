import 'package:flutter/material.dart';
import 'package:go_jo_user_application/widgets/custom_TitleText.dart';
import 'package:go_jo_user_application/widgets/custom_userFavCard.dart';

import '../widgets/custom_mainBar.dart';
import '../widgets/custom_returnArrow.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: customReturnArrow()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTitleText(title: 'Favorites', size: 35),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return customUserFavCard();
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavBar(currentIndex: 1),
    );
  }
}
