class SpaceNewsModel {
  final String id;
  final String title;
  final String newsSite; 
  final String newsSourceUrl;
  final String imageUrl;
  final String summary;
  final String publishedAt;

  SpaceNewsModel({
    required this.id,
    required this.title,
    required this.newsSite,
    required this.newsSourceUrl,
    required this.imageUrl,
    required this.summary,
    required this.publishedAt,
  });

  factory SpaceNewsModel.fromJson(Map<String, dynamic> json) => SpaceNewsModel(
    id: json["id"]?.toString() ?? "N/A",
    title: json["title"] ?? "N/A",
    newsSite: json["news_site"] ?? "Unknown Source", 
    newsSourceUrl: json["url"] ?? "N/A",
    imageUrl: json["image_url"] ?? "N/A",
    summary: json["summary"] ?? "N/A",
    publishedAt: json["published_at"] ?? "N/A",
  );
}