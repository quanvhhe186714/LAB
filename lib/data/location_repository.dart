import '../models/location.dart';

class LocationRepository {
  Future<List<Location>> getLocations() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      Location(
        name: 'Ha Long Bay',
        address: 'Quang Ninh, Vietnam',
        countStar: 5,
        imageUrl:
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
        description:
        'Ha Long Bay is a UNESCO World Heritage Site located in northern Vietnam.',
      ),
      Location(
        name: 'Da Nang Beach',
        address: 'Da Nang, Vietnam',
        countStar: 3,
        imageUrl:
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
        description: 'One of the most beautiful beaches in Vietnam.',
      ),
    ];
  }
}
