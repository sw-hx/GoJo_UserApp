import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_jo_user_application/core/helpers/helpers.dart';
import 'package:go_jo_user_application/presentation/pages/place_info_screen.dart';
import '../../domain/repos/place_repo.dart';
import '../../services/git_it_service.dart';
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
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        context.read<SearchCubit>().search(value);
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Type to search...',
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Icon(Icons.search, color: Colors.black, size: 26),
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
                        style: TextStyle(color: Colors.black54, fontSize: 16),
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
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    );
                  }

                  if (state is SearchSuccess) {
                    final results = state.places;

                    if (results.isEmpty) {
                      return const Center(
                        child: Text(
                          "No results",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final item = results[index];
                        return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(item.mainPhotoLink),
                        ),
                        title: Text(
                          formatPlace(item.placeName),
                          style: const TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) => GetPlaceInfoCubit(
                                      placeRepo: getIt<PlaceRepo>(),
                                    )..getPlaceInfo(item.placeName),
                                  ),
                                  BlocProvider(
                                    create: (context) => WriteCommentCubit(
                                      placeRepo: getIt<PlaceRepo>(),
                                    ),
                                  ),
                                ],
                                child: PlaceInfoScreen(),
                              ),
                            ),
                          );
                        },
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
