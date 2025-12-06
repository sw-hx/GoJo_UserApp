import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class PlaceCardsList extends StatefulWidget {
  const PlaceCardsList({super.key, required this.places});

  final List<dynamic> places;

  @override
  State<PlaceCardsList> createState() => _PlaceCardsListState();
}

class _PlaceCardsListState extends State<PlaceCardsList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.places.length,
        itemBuilder: (context, index) {
          final place = widget.places[index];
          return PlaceCard(
            title: formatPlace(place.placeName),
            description: place.quickInfo,
            imageUrl: place.mainPhotoLink,
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => GetPlaceInfoCubit(
                          placeRepo: getIt<PlaceRepo>(),
                        )..getPlaceInfo(place.placeName),
                      ),
                      BlocProvider(
                        create: (context) => WriteCommentCubit(
                          placeRepo: getIt<PlaceRepo>(),
                        ),
                      ),
                      BlocProvider(
                        create: (context) => AddFavoriteCubit(
                          favoriteRepo: getIt<FavoriteRepo>(),
                        ),
                      ),
                    ],
                    child: PlaceInfoScreen(),
                  ),
                ),
              );
              if (result == true) {
               context.read<GetPlacesByParentPlaceCubit>().getPlacesByParentPlace('ALL');
               setState(() {});
              }

            },
            isFavorite: place.isFavorite,
            placeId: place.placeId,

          );
        },
      ),
    );
  }
}

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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 190,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(widget.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
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
                    context.read<AddFavoriteCubit>().addFavorite(widget.placeId);
                    setState(() => isFav = true);
                  }
                },
                child: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.white,
                  size: 32,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
