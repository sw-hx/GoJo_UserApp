import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_jo_user_application/core/helpers/helpers.dart';
import 'package:go_jo_user_application/presentation/cubits/place_cubit/get_place_info_cubit/get_place_info_cubit.dart';
import 'package:go_jo_user_application/presentation/cubits/place_cubit/write_comment_cubit/write_comment_cubit.dart';
import 'package:go_jo_user_application/presentation/pages/home_page.dart';
import '../../data/models/place_models/place_model.dart';
import '../../domain/repos/trip_repo.dart';
import '../../services/git_it_service.dart';
import '../common_components/button_all.dart';
import '../common_components/bottom_nav_bar.dart';
import '../common_components/custom_divider.dart';
import '../common_components/custom_TitleText.dart';
import '../common_components/custom_returnArrow.dart';
import '../components/components_place_infoPage/comments_list.dart';
import '../components/components_place_infoPage/description_box.dart';
import '../components/components_place_infoPage/details.dart';
import '../components/components_place_infoPage/map.dart';
import '../components/components_place_infoPage/photos.dart';
import '../components/components_place_infoPage/place_image.dart';
import '../components/components_place_infoPage/weather.dart';
import '../cubits/favorite_cubit/add_favorite_cubit/add_favorite_cubit.dart';
import '../cubits/trip_cubit/get_trips_by_place_id_cubit.dart';
import 'trips.dart';

class PlaceInfoScreen extends StatefulWidget {
  const PlaceInfoScreen({super.key});

  @override
  State<PlaceInfoScreen> createState() => _PlaceInfoScreenState();
}

class _PlaceInfoScreenState extends State<PlaceInfoScreen> {
  bool isExpanded = false;
  bool showAllComments = false;
  late bool isFavorite;
  double userRating = 0.0;
  PlaceModel? place;
  

  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetPlaceInfoCubit, GetPlaceInfoState>(
      listener: (context, state) {
        if (state is GetPlaceInfoSuccess) {
          setState(() {
            place = state.place;
            isFavorite = state.place.isFavorite;
          });
        }
      },
      builder: (context, state) {
        if (state is GetPlaceInfoLoading || place == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return BlocConsumer<AddFavoriteCubit, AddFavoriteState>(
  listener: (context, state) {
    if (state is AddFavoriteSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("Place added to favorites")),
      );
    }

  },
  builder: (context, state) {
    return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomReturnArrow(targetPage: HomePage()),
                    ],
                  ),
                  const SizedBox(height: 16),

                  PlaceImage(
                    imageUrl: place!.mainPhotoLink,
                    name: formatPlace(place!.placeName),
                    isFavorite: isFavorite,
                    onFavoriteTap: () {
                      if (!isFavorite) {
                        context.read<AddFavoriteCubit>().addFavorite(place!.placeId);
                        setState(() {
                          isFavorite = true;
                        });
                      }
                    }
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
                        desc: formatPlace(place!.bestSeasonToVisit),
                        imageUrl: "https://cdn-icons-png.flaticon.com/512/869/869869.png",
                      ),
                      DetailBox(
                        title: "Total Visitors",
                        desc: '${place?.totalNumberOfVisitor ?? 0} tourists in ${place?.onThisYear}',
                        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                      ),
                      if (place!.isSevenWonder)
                        DetailBox(
                          title: "Seven Wonder",
                          desc: "",
                          imageUrl: 'https://images.icon-icons.com/1808/PNG/512/star_115223.png',
                        ),
                    ],
                  ),

                  customDivider(),
                  customTitleText(title: 'Photos', size: 22),

                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:  [
                        PhotoBox(url: place!.subPhotoOneLink),
                        PhotoBox(url: place!.subPhotoTwoLink),
                        PhotoBox(url: place!.subPhotoThreeLink),
                        PhotoBox(url: place!.subPhotoFourLink),
                        PhotoBox(url: place!.subPhotoFiveLink),
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
                  customTitleText(title: 'Your Review', size: 22),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Rate & Review",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 10),

                        RatingBar.builder(
                          initialRating: userRating,
                          minRating: 1,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 35,
                          itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
                          onRatingUpdate: (rating) => setState(() => userRating = rating),
                        ),

                        const SizedBox(height: 15),

                        TextField(
                          controller: commentController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: "Write your comment here...",
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        BlocConsumer<WriteCommentCubit, WriteCommentState>(
                          listener: (context, wcState) {
                            if (wcState is WriteCommentSuccess) {
                              setState(() {
                                place!.listAllUsersReviews.insert(0, wcState.review);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Review added successfully")),
                              );
                              commentController.clear();
                              setState(() => userRating = 0.0);
                            }

                            if (wcState is WriteCommentError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(wcState.message)),
                              );
                            }
                          },
                          builder: (context, wcState) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff2F7898),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  if (userRating == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Please rate the place first")),
                                    );
                                    return;
                                  }

                                  context.read<WriteCommentCubit>().addReview(
                                    rating: userRating.toInt(),
                                    reviewText: commentController.text.trim(),
                                    placeId: place!.placeId,
                                  );
                                },
                                child: wcState is WriteCommentLoading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : const Text(
                                  "Submit Review",
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  customDivider(),
                  customTitleText(title: 'Weather', size: 22),
                  const WeatherList(),

                  customDivider(),
                  customTitleText(title: 'Map', size: 22),
                  MapSection(),

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
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (context) => GetTripsByPlaceIdCubit(
                              tripRepo: getIt<TripRepo>(),
                            )..getTripsByPlaceId(placeId: place!.placeId),
                            child: const TripsCardPage(),
                          ),
                        ),
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
      },
    );
  }
}
