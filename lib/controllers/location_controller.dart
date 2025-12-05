import 'package:flutter/material.dart';
import '../models/location_point.dart';
import '../repositories/location_repository.dart';
import 'package:uuid/uuid.dart';

class LocationController with ChangeNotifier {
  final repo = LocationRepository();
  bool showOnlyMine = false;

  List<LocationPoint> locations = [];

  void loadLocations({required String email}) {
    locations = showOnlyMine ? repo.getByUser(email) : repo.getAll();
    notifyListeners();
  }

  Future<void> addLocation({
    required String email,
    required double lat,
    required double lng,
    required String description,
    required DateTime date,
  }) async {
    final point = LocationPoint(
      id: const Uuid().v4(),
      userEmail: email,
      lat: lat,
      lng: lng,
      description: description,
      date: DateTime.now(),
    );

    await repo.addLocation(point);
    loadLocations(email: email);
  }

  void toggleShowMine(String email) {
    showOnlyMine = !showOnlyMine;
    loadLocations(email: email);
  }
}
