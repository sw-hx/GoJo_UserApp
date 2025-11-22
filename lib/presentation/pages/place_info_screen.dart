import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../common_components/button_all.dart';
import '../common_components/bottom_nav_bar.dart';
import '../common_components/custom_divider.dart';
import '../common_components/custom_TitleText.dart';
import '../components/components_place_infoPage/comments_list.dart';
import '../components/components_place_infoPage/description_box.dart';
import '../components/components_place_infoPage/details.dart';
import '../components/components_place_infoPage/map.dart';
import '../components/components_place_infoPage/photos.dart';
import '../components/components_place_infoPage/place_data.dart';
import '../components/components_place_infoPage/place_image.dart';
import '../components/components_place_infoPage/weather.dart';
import 'trips.dart';



class PlaceInfoScreen extends StatefulWidget {
  const PlaceInfoScreen({super.key});

  @override
  State<PlaceInfoScreen> createState() => _PlaceInfoScreenState();
}

class _PlaceInfoScreenState extends State<PlaceInfoScreen> {
  bool isExpanded = false;
  bool showAllComments = false;
  bool isFavorite = false;
  double userRating = 0.0;

  @override
  Widget build(BuildContext context) {
    final place = petraPlace;

    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: ListView(
              children: [
                // Image + Name + Favorite
                PlaceImage(
                  imageUrl: place.image,
                  name: place.name,
                  isFavorite: isFavorite,
                  onFavoriteTap: () => setState(() => isFavorite = !isFavorite),
                ),
                const SizedBox(height: 10),

                // Description
                DescriptionBox(
                  name: place.name,
                  description: place.description,
                  isExpanded: isExpanded,
                  toggleExpand: () => setState(() => isExpanded = !isExpanded),
                ),
                customDivider(),

                // Details
                customTitleText(title: 'Details', size: 22),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: place.details
                      .map((d) => DetailBox(
                    title: d["title"]!,
                    desc: d["desc"]!,
                    imageUrl: d["image"]!,
                  ))
                      .toList(),
                ),
                customDivider(),

                // Photos
                customTitleText(title: 'Photos', size: 22),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: place.photos.length,
                    itemBuilder: (context, index) => PhotoBox(url: place.photos[index]),
                  ),
                ),
                customDivider(),

                // Rating
                customTitleText(title: 'Rating', size: 22),
                RatingBarIndicator(
                  rating: place.rating,
                  itemCount: 5,
                  itemSize: 45,
                  itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                  unratedColor: Colors.grey.shade300,
                ),
                const SizedBox(height: 8),
                Text(
                  "${place.rating} / 5.0",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                customDivider(),

                // Comments
                customTitleText(title: 'Comments', size: 22),
                CommentList(comments: place.comments, showAll: showAllComments),
                GestureDetector(
                  onTap: () => setState(() => showAllComments = !showAllComments),
                  child: Text(
                    showAllComments ? 'Less Comments' : 'More Comments',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                customDivider(),

                // Rate
                customTitleText(title: 'Rate this place', size: 22),
                RatingBar.builder(
                  initialRating: userRating,
                  minRating: 1,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    setState(() {
                      userRating = rating;
                    });
                  },
                ),
                const SizedBox(height: 8),
                customDivider(),

                // Add comment
                customTitleText(title: 'Add a comment', size: 22),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                    suffixIcon: const Icon(Icons.check, color: Colors.black, size: 30),
                    hintText: "Write here...",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  ),
                ),
                customDivider(),

                // Weather
                customTitleText(title: 'Weather', size: 22),
                const WeatherList(),
                customDivider(),

                // Map
                customTitleText(title: 'Map', size: 22),
                const MapSection(),
                customDivider(),

                // Trips Button
                const Text(
                  'Available Trips',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amber, fontSize: 30, fontWeight: FontWeight.bold),
                ),
                CustomButton(
                  text: "New Adventure",
                  color: const Color(0xff2F7898),
                  height: 60,
                  width: 250,
                  fontSize: 30,
                  borderRadius: 20,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const TripsCardPage()));
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
        );
    }
}
