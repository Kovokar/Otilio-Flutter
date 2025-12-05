class LocationPoint {
  final String id;
  final String userEmail;
  final double lat;
  final double lng;
  final String description;
  final DateTime date;

  LocationPoint({
    required this.id,
    required this.userEmail,
    required this.lat,
    required this.lng,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userEmail': userEmail,
        'lat': lat,
        'lng': lng,
        'description': description,
        'date': date.toIso8601String(),
      };

  factory LocationPoint.fromJson(Map<String, dynamic> json) => LocationPoint(
        id: json['id'],
        userEmail: json['userEmail'],
        lat: json['lat'],
        lng: json['lng'],
        description: json['description'],
        date: DateTime.parse(json['date']),
      );
}
