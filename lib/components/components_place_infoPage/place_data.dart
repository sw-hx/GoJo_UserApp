class PlaceData {
  final String name;
  final String description;
  final String image;
  final double rating;
  final List<String> photos;
  final List<Map<String, String>> details;
  final List<Map<String, String>> comments;

  PlaceData({
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.photos,
    required this.details,
    required this.comments,
  });
}

final PlaceData petraPlace = PlaceData(
  name: "Petra",
  description: "The area around Petra has been inhabited from as early as 7000 BC, and was settled by the Nabataeans. It’s one of the most visited archaeological sites in the world and one of the New Seven Wonders.",
  image: 'https://preview.redd.it/the-ancient-city-of-petra-jordan-petra-was-founded-over-v0-1owlnruxk9391.jpg?width=640&crop=smart&auto=webp&s=cdc13b91ce4a002779aec0d1d427281c88d9f643',
  rating: 4.8,
  photos: [
    'https://preview.redd.it/the-ancient-city-of-petra-jordan-petra-was-founded-over-v0-1owlnruxk9391.jpg?width=640&crop=smart&auto=webp&s=cdc13b91ce4a002779aec0d1d427281c88d9f643',
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ-PVVc3NBPWO3-oOaoGtmqbThht1KjcAr8XPFvf32CxIKSx6ZL9ioffPsU4x6CRJxST0&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY_fD9IDXE5fHsSavuvxpHfQJbcZgdjeIy17R0dgaxItmy8JNHog99f0EbyDx8w16B8bE&usqp=CAU",
  ],
  details: [
    {"title": "Season", "desc": "Preferred in Spring", "image": "https://cdn-icons-png.flaticon.com/512/869/869869.png"},
    {"title": "7 Wonders", "desc": "One of the 7 wonders of the world", "image": "https://cdn-icons-png.flaticon.com/512/616/616408.png"},
    {"title": "Visitors", "desc": "45,454 tourists in 2021", "image": "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"},
  ],
  comments: [
  {"name": "Zain", "comment": "Wow great place!"},
  {"name": "Omar", "comment": "Amazing experience"},
  {"name": "Sara", "comment": "A must visit spot"},
  {"name": "Huda", "comment": "Love the history here"},
  {"name": "Tariq", "comment": "Petra at night is magical"},
  ],
);
