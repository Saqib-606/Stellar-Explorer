class ApodModel {
  final String title;
  final String date;
  final String explanation;
  final String url;
  final String? hdurl;  
  final String mediaType;
  final String? copyright;
  final String serviceversion;

  ApodModel({
    required this.title,
    required this.date,
    required this.explanation,
    required this.url,
    this.hdurl,
    required this.mediaType,
    this.copyright,
    required this.serviceversion,
  });

  factory ApodModel.fromJson (Map<String,dynamic> json) {
    return ApodModel(
      title: json["title"] ?? "No Title",
      date: json["date"] ?? "",
      explanation: json["explanation"]?? "",
      url: json["url"] ?? "",
      hdurl: json["hdurl"],
      mediaType: json["media_type"] ?? "",
      copyright: json["copyright"],
      serviceversion: json["service_version"] ?? "",
    );
  }
}