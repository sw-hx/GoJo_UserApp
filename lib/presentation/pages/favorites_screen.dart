import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_jo_user_application/presentation/cubits/favorite_cubit/delete_favorite_cubit/delete_favorite_cubit.dart';
import '../../data/models/favorite_model.dart';
import '../../domain/repos/favorite_repo.dart';
import '../../services/git_it_service.dart';
import '../common_components/custom_returnArrow.dart';
import '../common_components/bottom_nav_bar.dart';
import '../components/components_favoritesPage/favorites_Card.dart';
import '../cubits/favorite_cubit/get_favorites_cubit/get_favorites_cubit.dart';
import 'home_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<FavoriteModel> favoritePlaces = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          GetFavoritesCubit(
            favoriteRepo: getIt<FavoriteRepo>(),
          )
            ..getFavorites(),
        ),
        BlocProvider(
          create: (context) =>
              DeleteFavoriteCubit(
                favoriteRepo: getIt<FavoriteRepo>(),
              ),
        ),
      ],
      child: BlocConsumer<GetFavoritesCubit, GetFavoritesState>(
        listener: (context, state) {
          if (state is GetFavoritesSuccess) {
            favoritePlaces = state.favorites;
            setState(() {});
          }
          if (state is GetFavoritesFailure) {
            SnackBar(content: Text(state.message));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey[100],
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

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

                      BlocConsumer<DeleteFavoriteCubit, DeleteFavoriteState>(
                        listener: (context, state) {
                          if (state is DeleteFavoriteSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Favorite deleted successfully")),
                            );
                            setState(() {});
                          }
                          if (state is DeleteFavoriteFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            children: favoritePlaces
                                .asMap()
                                .entries
                                .map(
                                  (entry) =>
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 18.0),
                                    child: FavoriteCard(
                                      place: entry.value,
                                      onDelete: () {
                                        setState(() {
                                          context.read<DeleteFavoriteCubit>().deleteFavorite(favoriteId: entry.value.favoriteId);
                                          favoritePlaces.removeAt(entry.key);
                                        });
                                      },
                                    ),
                                  ),
                            )
                                .toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: const BottomNavBar(currentIndex: 1),

          );
        },
      ),
    );
  }
}
