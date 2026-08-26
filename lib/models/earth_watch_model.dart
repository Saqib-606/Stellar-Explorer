class EarthWatchModel {
  final String id;
  final String title;
  final List<dynamic> categories; 
  final List<dynamic> geometry;   

  EarthWatchModel({
    required this.id,
    required this.title,
    required this.categories,
    required this.geometry,
  });

  factory EarthWatchModel.fromJson(Map<String, dynamic> json) => EarthWatchModel(
    id: json["id"]?.toString() ?? "N/A",
    title: json["title"] ?? "N/A",
    categories: json["categories"] ?? [],
    geometry: json["geometry"] ?? [],
  );
}