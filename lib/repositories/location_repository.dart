import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/location_point.dart';

class LocationRepository {
  final _box = Hive.box('locations');

  Future<void> addLocation(LocationPoint point) async {
    _box.put(point.id, point.toJson());
  }

  List<LocationPoint> getAll() {
    return _box.values
        .map((json) => LocationPoint.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  List<LocationPoint> getByUser(String email) {
    return getAll().where((p) => p.userEmail == email).toList();
  }
}
