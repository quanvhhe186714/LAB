import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'location_repository.dart';
import '../models/location.dart';

final locationRepositoryProvider =
Provider<LocationRepository>((ref) {
  return LocationRepository();
});

final locationProvider =
FutureProvider<List<Location>>((ref) async {
  final repo = ref.read(locationRepositoryProvider);
  return repo.getLocations();
});
