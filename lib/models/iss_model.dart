class IssModel {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final double altitude;
  final double velocity;
  final String visibility;
  final double footPrint;
  final int timeStamp;
  final double dayNum;
  final double solarLat;
  final double solarLon;
  final String units;

  IssModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.velocity,
    required this.visibility,
    required this.footPrint,
    required this.timeStamp,
    required this.dayNum,
    required this.solarLat,
    required this.solarLon,
    required this.units,
  });

  factory IssModel.fromJson (Map <String, dynamic> json) {
    return IssModel(
      id: json["id"]?.toString() ?? "NA",
      name: json["name"] ?? "N/A",
      latitude: (json["latitude"] as num?)?.toDouble() ?? 0.0,
      longitude: (json["longitude"] as num?)?.toDouble() ?? 0.0,
      altitude: (json["altitude"] as num?)?.toDouble() ?? 0.0,
      velocity: (json["velocity"] as num?)?.toDouble() ?? 0.0,
      visibility: json["visibility"] ?? "Unknown",
      footPrint: (json["footprint"] as num?)?.toDouble() ?? 0.0,
      timeStamp: (json["timestamp"] as int?) ?? 0,
      dayNum: (json["daynum"] as num?)?.toDouble() ?? 0.0,
      solarLat: (json["solar_lat"] as num?)?.toDouble() ?? 0.0,
      solarLon: (json["solar_lon"] as num?)?.toDouble() ?? 0.0,
      units: json["units"] ?? "N/A",
    );
  }
}