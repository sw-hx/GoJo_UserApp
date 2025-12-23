import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:go_jo_user_application/presentation/pages/place_info_screen.dart';
import '../../../core/helpers/helpers.dart';
import '../../../domain/repos/favorite_repo.dart';
import '../../../domain/repos/place_repo.dart';
import '../../../services/git_it_service.dart';
import '../../cubits/favorite_cubit/add_favorite_cubit/add_favorite_cubit.dart';
import '../../cubits/place_cubit/get_place_info_cubit/get_place_info_cubit.dart';
import '../../cubits/place_cubit/write_comment_cubit/write_comment_cubit.dart';

/// coded by [suhaib]

class PopularCard extends StatelessWidget {
  final List<dynamic> places;

  const PopularCard({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];

          return _PopularItem(
            place: place,
            index: index,
          );
        },
      ),
    );
  }
}

/// =======================================================
///                    SINGLE POPULAR CARD
/// =======================================================
class _PopularItem extends StatefulWidget {
  final dynamic place;
  final int index;

  const _PopularItem({
    required this.place,
    required this.index,
  });

  @override
  State<_PopularItem> createState() => _PopularItemState();
}

class _PopularItemState extends State<_PopularItem> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    final place = widget.place;

    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.95),
      onTapUp: (_) => setState(() => scale = 1),
      onTapCancel: () => setState(() => scale = 1),
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
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          width: 240,
          height: 110,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              children: [
                /// 🖼 IMAGE
                Image.network(
                  place.mainPhoto,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),

                /// 🌑 GRADIENT
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.65),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                /// 📝 TITLE + ⭐ RATING
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
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

                        /// ⭐ Rating Badge (Pop)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade700,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            place.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 300.ms)
                            .scale(
                          begin: const Offset(0.6, 0.6),
                          curve: Curves.easeOutBack,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
    /// 🔥 STAGGERED ENTRANCE
        .animate(delay: (widget.index * 100).ms)
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.3)
        .scale(begin: const Offset(0.95, 0.95));
  }
}
