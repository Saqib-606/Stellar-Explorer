class NasaImagesModel {
  final String title;
  final String description;
  final String mediaType;
  final String dateCreated;
  final String nasaId;
  final String imageUrl;

  NasaImagesModel({
    required this.title,
    required this.description,
    required this.mediaType,
    required this.dateCreated,
    required this.nasaId,
    required this.imageUrl,
  });

  factory NasaImagesModel.fromJson (Map<String, dynamic> json) {
    final dataList = json['data'] as List? ?? [];
    final dataItem = dataList.isNotEmpty ? dataList[0] : {};

    final linksList = json['links'] as List? ?? [];
    final linkItem = linksList.isNotEmpty ? linksList[0] : {};

    return NasaImagesModel(
      title: dataItem['title'] ?? 'No Title',
      description: dataItem['description'] ?? 'No Description Available',
      mediaType: dataItem['media_type'] ?? 'image',
      dateCreated: dataItem['date_created'] ?? '',
      nasaId: dataItem['nasa_id'] ?? '',
      imageUrl: linkItem['href'] ?? '',
    );
  }
}