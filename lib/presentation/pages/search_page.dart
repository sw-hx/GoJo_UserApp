import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_jo_user_application/core/helpers/helpers.dart';
import 'package:go_jo_user_application/presentation/pages/place_info_screen.dart';
import '../../domain/repos/favorite_repo.dart';
import '../../domain/repos/place_repo.dart';
import '../../services/git_it_service.dart';
import '../cubits/favorite_cubit/add_favorite_cubit/add_favorite_cubit.dart';
import '../cubits/place_cubit/get_place_info_cubit/get_place_info_cubit.dart';
import '../cubits/place_cubit/write_comment_cubit/write_comment_cubit.dart';
import '../cubits/search_cubit/search_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 52,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(left: 18, right: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        context.read<SearchCubit>().search(value);
                      },
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search places...',
                        hintStyle:
                        TextStyle(color: Colors.grey.shade600),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Icon(Icons.search, color: Colors.black, size: 28),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return const Center(
                      child: Text(
                        "Start typing to search",
                        style:
                        TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                    );
                  }

                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }

                  if (state is SearchFailure) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(
                            color: Colors.red, fontSize: 16),
                      ),
                    );
                  }

                  if (state is SearchSuccess) {
                    final results = state.places;

                    if (results.isEmpty) {
                      return const Center(
                        child: Text(
                          "No results",
                          style: TextStyle(
                              color: Colors.black54, fontSize: 16),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: results.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = results[index];

                        return InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (context) =>
                                      GetPlaceInfoCubit(
                                        placeRepo:
                                        getIt<PlaceRepo>(),
                                      )..getPlaceInfo(
                                          item.placeName),
                                    ),
                                    BlocProvider(
                                      create: (context) =>
                                          WriteCommentCubit(
                                            placeRepo:
                                            getIt<PlaceRepo>(),
                                          ),
                                    ),
                                    BlocProvider(
                                      create: (context) =>
                                          AddFavoriteCubit(
                                            favoriteRepo:
                                            getIt<FavoriteRepo>(),
                                          ),
                                    ),
                                  ],
                                  child: const PlaceInfoScreen(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.08),
                                  blurRadius: 10,
                                  offset:
                                  const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(16),
                                  child: Image.network(
                                    item.mainPhotoLink,
                                    width: 72,
                                    height: 72,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    formatName(item.placeName),
                                    softWrap: true,
                                    overflow:
                                    TextOverflow.visible,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
