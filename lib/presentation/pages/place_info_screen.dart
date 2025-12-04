import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_jo_user_application/core/helpers/helpers.dart';
import 'package:go_jo_user_application/presentation/cubits/place_cubit/get_place_info_cubit/get_place_info_cubit.dart';
import '../../data/models/place_models/place_model.dart';
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
  PlaceModel? place;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetPlaceInfoCubit, GetPlaceInfoState>(
      listener: (context, state) {
        if (state is GetPlaceInfoSuccess) {
          setState(() {
            place = state.place;
          });
        }
      },
      builder: (context, state) {
        if (state is GetPlaceInfoLoading || place == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: ListView(
                children: [
                  PlaceImage(
                    //place!.mainPhotoLink,
                    imageUrl: "assets/images/petra.jpg",
                    name: formatPlace(place!.placeName),
                    isFavorite: isFavorite,
                    onFavoriteTap: () => setState(() => isFavorite = !isFavorite),
                  ),
                  const SizedBox(height: 10),
                  DescriptionBox(
                    name: formatPlace(place!.placeName),
                    description: place!.placeInfo,
                    isExpanded: isExpanded,
                    toggleExpand: () => setState(() => isExpanded = !isExpanded),
                  ),
                  customDivider(),
                  customTitleText(title: 'Details', size: 22),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      DetailBox(
                        title: "Best Season",
                        desc: place!.bestSeasonToVisit,
                        icon: Icons.wb_sunny,
                      ),
                      DetailBox(
                        title: "Total Visitors",
                        desc: place!.totalNumberOfVisitor?.toString() ?? "0",
                        icon: Icons.people,
                      ),
                      DetailBox(
                        title: "This Year",
                        desc: place!.onThisYear?.toString() ?? "N/A",
                        icon: Icons.calendar_today,
                      ),

                      if (place!.isSevenWonder == true)
                        DetailBox(
                          title: "Seven Wonder",
                          desc: "Yes",
                          icon: Icons.workspace_premium,
                        ),
                    ],
                  ),

                  customDivider(),
                  customTitleText(title: 'Photos', size: 22),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        //place!.subPhotoOneLink,
                        PhotoBox(url: "assets/images/petra.jpg",),
                        //place!.subPhotoTwoLink,
                        PhotoBox(url: "assets/images/petra.jpg"),
                        //place!.subPhotoThreeLink,
                        PhotoBox(url: "assets/images/petra.jpg"),
                        //place!.subPhotoFourLink,
                        PhotoBox(url: "assets/images/petra.jpg"),
                        //place!.subPhotoFiveLink,
                        PhotoBox(url: "assets/images/petra.jpg"),
                      ],
                    ),
                  ),
                  customDivider(),
                  customTitleText(title: 'Rating', size: 22),
                  RatingBarIndicator(
                    rating: place!.averagePlaceRating,
                    itemCount: 5,
                    itemSize: 45,
                    itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${place!.averagePlaceRating.toStringAsFixed(1)} / 5.0",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  customDivider(),
                  customTitleText(title: 'Comments', size: 22),
                  CommentList(
                    comments: place!.listAllUsersReviews,
                    showAll: showAllComments,
                  ),
                  GestureDetector(
                    onTap: () => setState(() => showAllComments = !showAllComments),
                    child: Text(
                      showAllComments ? 'Less Comments' : 'More Comments',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  customDivider(),
                  customTitleText(title: 'Rate this place', size: 22),
                  RatingBar.builder(
                    initialRating: userRating,
                    minRating: 1,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {
                      setState(() => userRating = rating);
                    },
                  ),
                  const SizedBox(height: 8),
                  customDivider(),
                  customTitleText(title: 'Add a comment', size: 22),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                      suffixIcon: const Icon(Icons.check, color: Colors.black, size: 30),
                      hintText: "Write here...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  customDivider(),
                  customTitleText(title: 'Weather', size: 22),
                  const WeatherList(),
                  customDivider(),
                  customTitleText(title: 'Map', size: 22),
                  MapSection(
                      //url: place!.placeLocation
                  ),
                  customDivider(),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TripsCardPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavBar(currentIndex: 0),
        );
      },
    );
  }
}
