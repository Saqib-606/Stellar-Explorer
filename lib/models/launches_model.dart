class LaunchesModel {
  final String id;
  final String name;
  final String status; 
  final String net;  // Next Exact Time
  final String launchServiceProvider; 
  final String pad; 
  final String image;
  final String missionDescription; 

  LaunchesModel({
    required this.id,
    required this.name,
    required this.status,
    required this.net,
    required this.launchServiceProvider,
    required this.pad,
    required this.image,
    required this.missionDescription,
  });

  factory LaunchesModel.fromJson(Map<String, dynamic> json) => LaunchesModel(
    id: json["id"] ?? "N/A",
    name: json["name"] ?? "Unknown Launch",    
    status: json["status"]?["name"] ?? "Unknown Status", 
    net: json["net"] ?? "N/A",    
    launchServiceProvider: json["launch_service_provider"]?["name"] ?? "Unknown Provider",    
    pad: json["pad"]?["name"] ?? "Unknown Location",
    image: json["image"] ?? "N/A",
    missionDescription: json["mission"]?["description"] ?? "Mission details are classified or unavailable.",
  );
}