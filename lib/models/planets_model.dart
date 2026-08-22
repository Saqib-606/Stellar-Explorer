class PlanetsModel {
  final String planetId;
  final String planetName;
  final List<dynamic> planetMoons;
  final Map<String, dynamic>? planetMass; 
  final Map<String, dynamic>? planetVolume;
  final double planetDensity;
  final double planetGravity;
  final String planetDiscoveryBy;
  final String planetDiscoveryDate;
  final int averageTemp;
  final double sideralOrbit;
  final double sideralRotation;

  PlanetsModel({
    required this.planetId,
    required this.planetName,
    required this.planetMoons,
    required this.planetMass,
    required this.planetVolume,
    required this.planetDensity,
    required this.planetGravity,
    required this.planetDiscoveryBy,
    required this.planetDiscoveryDate,
    required this.averageTemp,
    required this.sideralOrbit,
    required this.sideralRotation
  });

  factory PlanetsModel.fromJson (Map<String, dynamic> json) {
    return PlanetsModel(
      planetId: json["id"] ?? "N/A",
      planetName: json["englishName"] ?? "N/A",
      planetMoons: json["moons"] ?? [],      
      planetMass: json["mass"], 
      planetVolume: json["vol"],      
      planetDensity: (json["density"] as num?)?.toDouble() ?? 0.0,
      planetGravity: (json["gravity"] as num?)?.toDouble() ?? 0.0,
      planetDiscoveryBy: json["discoveredBy"] ?? "N/A",
      planetDiscoveryDate: json["discoveryDate"] ?? "N/A",
      averageTemp: (json["avgTemp"] as num?)?.toInt() ?? 0,
      sideralOrbit: (json["sideralOrbit"] as num?)?.toDouble() ?? 0.0,
      sideralRotation: (json["sideralRotation"] as num?)?.toDouble() ?? 0.0,
    );
  }
}