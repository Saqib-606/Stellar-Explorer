class ExoplanetsModel {
  final String planetName;
  final String hostName;
  final String discoveryMethod;
  final String discoveryYear;
  final String planetRadius;
  final String planetMass;

  ExoplanetsModel({
    required this.planetName,
    required this.hostName,
    required this.discoveryMethod,
    required this.discoveryYear,
    required this.planetRadius,
    required this.planetMass,
  });

  factory ExoplanetsModel.fromJson (Map<String, dynamic> json) {
    return ExoplanetsModel(
      planetName: json["pl_name"]?.toString() ?? "Unknown",
      hostName: json["hostname"]?.toString() ?? "Unknown",
      discoveryMethod: json["discoverymethod"]?.toString() ?? "Unknown",
      discoveryYear: json["disc_year"]?.toString() ?? "Unknown",
      planetRadius: json["pl_rade"]?.toString() ?? "N/A",
      planetMass: json["pl_masse"]?.toString() ?? "N/A",
    );
  }
}