import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_jo_user_application/core/helpers/helpers.dart';
import 'package:go_jo_user_application/presentation/cubits/favorite_cubit/add_favorite_cubit/add_favorite_cubit.dart';
import '../../../data/models/place_models/place_model.dart';
import '../../../domain/repos/favorite_repo.dart';
import '../../../domain/repos/place_repo.dart';
import '../../../services/git_it_service.dart';
import '../../cubits/place_cubit/get_place_info_cubit/get_place_info_cubit.dart';
import '../../cubits/place_cubit/get_places_by_parentPlace/get_places_by_parent_place_cubit.dart';
import '../../cubits/place_cubit/write_comment_cubit/write_comment_cubit.dart';
import '../../pages/place_info_screen.dart';

/// coded by [suhaib]

class PlaceCardsList extends StatelessWidget {
  const PlaceCardsList({super.key, required this.places});

  final List<dynamic> places;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];

          return PlaceCard(
            key: ValueKey(place.placeId),
            title: formatName(place.placeName),
            description: place.quickInfo,
            imageUrl: place.mainPhotoLink,
            isFavorite: place.isFavorite,
            placeId: place.placeId,
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (_) => GetPlaceInfoCubit(
                          placeRepo: getIt<PlaceRepo>(),
                        )..getPlaceInfo(place.placeName),
                      ),
                      BlocProvider(
                        create: (_) => WriteCommentCubit(
                          placeRepo: getIt<PlaceRepo>(),
                        ),
                      ),
                      BlocProvider(
                        create: (_) => AddFavoriteCubit(
                          favoriteRepo: getIt<FavoriteRepo>(),
                        ),
                      ),
                    ],
                    child: PlaceInfoScreen(
                      heroTag: 'place_${place.placeId}',
                    ),
                  ),
                ),
              );

              if (result == true) {
                context
                    .read<GetPlacesByParentPlaceCubit>()
                    .getPlacesByParentPlace('ALL');
              }
            },
          )
              .animate(delay: (index * 120).ms)
              .fadeIn(duration: 500.ms)
              .slideX(begin: 0.3)
              .scale(begin: const Offset(0.95, 0.95));
        },
      ),
    );
  }
}

/// =======================================================
///                        PLACE CARD
/// =======================================================
class PlaceCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final Future<void> Function() onTap;
  final bool isFavorite;
  final int placeId;

  const PlaceCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onTap,
    required this.isFavorite,
    required this.placeId,
  });

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  late bool isFav;

  @override
  void initState() {
    super.initState();
    isFav = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddFavoriteCubit, AddFavoriteState>(
      listener: (context, state) {
        if (state is AddFavoriteFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 150),
          scale: 1,
          child: Container(
            width: 190,
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
                  /// 🔥 HERO IMAGE
                  Hero(
                    tag: 'place_${widget.placeId}',
                    child: Image.network(
                      widget.imageUrl,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// Gradient
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        if (!isFav) {
                          context
                              .read<AddFavoriteCubit>()
                              .addFavorite(widget.placeId);
                          setState(() => isFav = true);
                        }
                      },
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.white,
                        size: 34,
                      )
                          .animate(target: isFav ? 1 : 0)
                          .scale(
                          begin: const Offset(1, 1),
                          end: const Offset(1.3, 1.3),
                          curve: Curves.easeOutBack)
                          .then()
                          .scale(end: const Offset(1, 1)),
                    ),
                  ),

                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(delay: 300.ms)
                        .slideY(begin: 0.3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
