class SpaceWeatherModel {
  final String activityId;
  final String startTime;
  final String sourceLocation;
  final String note;
  final String link;
  final List<dynamic> cmeAnalyses;

  SpaceWeatherModel({
    required this.activityId,
    required this.startTime,
    required this.sourceLocation,
    required this.note,
    required this.link,
    required this.cmeAnalyses,
  });

  factory SpaceWeatherModel.fromJson (Map<String, dynamic> json) {
    return SpaceWeatherModel(
      activityId: json["activityID"] ?? "N/A",
      startTime: json["startTime"] ?? "N/A",
      sourceLocation: json["sourceLocation"] ?? "N/A",
      note: json["note"] ?? "",
      link: json["link"] ?? "",
      cmeAnalyses: json["cmeAnalyses"] ?? [],
    );
  }
}