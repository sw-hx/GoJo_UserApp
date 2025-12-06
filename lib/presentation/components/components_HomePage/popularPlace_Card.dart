import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_jo_user_application/presentation/pages/place_info_screen.dart';
import '../../../core/helpers/helpers.dart';
import '../../../domain/repos/favorite_repo.dart';
import '../../../domain/repos/place_repo.dart';
import '../../../services/git_it_service.dart';
import '../../cubits/favorite_cubit/add_favorite_cubit/add_favorite_cubit.dart';
import '../../cubits/place_cubit/get_place_info_cubit/get_place_info_cubit.dart';
import '../../cubits/place_cubit/write_comment_cubit/write_comment_cubit.dart';

class PopularCard extends StatelessWidget {
  final List<dynamic> places;

  const PopularCard({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(places.length, (index) {
          final place = places[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (_) => GetPlaceInfoCubit(
                          placeRepo: getIt.get<PlaceRepo>(),
                        )..getPlaceInfo(place.name),
                      ),
                      BlocProvider(
                        create: (_) => WriteCommentCubit(
                          placeRepo: getIt.get<PlaceRepo>(),
                        ),
                      ),
                      BlocProvider(
                        create: (_) => AddFavoriteCubit(
                          favoriteRepo: getIt.get<FavoriteRepo>(),
                        ),
                      ),
                    ],
                    child: const PlaceInfoScreen(),
                  ),
                ),
              );
            },
            child: Container(
              width: 240,
              height: 110,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(
                    //place.mainPhoto
                    'https://www.sarayanews.com/image.php?token=e96b92baf594b10580b33117270c9996&size=',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              formatPlace(place.name),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.yellow.shade700,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              place.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
