class IssLocationModel {
  final double latitude;
  final double longitude;
  final String continent;
  final String country;
  final String locality;

  IssLocationModel({
    required this.latitude,
    required this.longitude,
    required this.continent,
    required this.country,
    required this.locality,
  });

  factory IssLocationModel.fromJson(Map<String, dynamic> json) => IssLocationModel(
    latitude: (json["latitude"] as num?)?.toDouble() ?? 0.0,
    longitude: (json["longitude"] as num?)?.toDouble() ?? 0.0,
    continent: json["continent"] ?? "",
    country: json["countryName"] ?? "",
    locality: json["locality"] ?? "Unknown Location",
  );
}