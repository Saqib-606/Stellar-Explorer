class AsteroidsModel {
  final String id;
  final String name;
  final double absoluteMagnitude;
  final bool isHazardous;
  final bool isSentryObject;
  final List<dynamic> closeApproachData;

  AsteroidsModel({
    required this.id,
    required this.name,
    required this.absoluteMagnitude,
    required this.isHazardous,
    required this.isSentryObject,
    required this.closeApproachData,
  });

  factory AsteroidsModel.fromJson (Map<String, dynamic> json) {
    return AsteroidsModel(
      id: json["id"] ?? "N/A",
      name: json["name"] ?? "Unknown Asteroid",
      absoluteMagnitude: (json["absolute_magnitude_h"] as num).toDouble(),
      isHazardous: json["is_potentially_hazardous_asteroid"] ?? false,
      isSentryObject: json["is_sentry_object"] ?? false,
      closeApproachData: json["close_approach_data"] ?? [],
    );
  }
}