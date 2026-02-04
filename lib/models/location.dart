class Location {
  final String name;
  final String address;
  final String description;
  final String imageUrl;
  int countStar; // ❗ bỏ final

  Location({
    required this.name,
    required this.address,
    required this.description,
    required this.imageUrl,
    required this.countStar,
  });
}
