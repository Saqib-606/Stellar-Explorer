import 'package:dio/dio.dart';
import 'package:stellar_explorer/models/apod_model.dart';
import 'package:stellar_explorer/models/asteroids_model.dart';
import 'package:stellar_explorer/models/exoplanets_model.dart';
import 'package:stellar_explorer/models/iss_model.dart';
import 'package:stellar_explorer/models/launches_model.dart';
import 'package:stellar_explorer/models/nasa_images_model.dart';
import 'package:stellar_explorer/models/planets_model.dart';
import 'package:stellar_explorer/models/space_news_model.dart';
import 'package:stellar_explorer/models/space_weather_model.dart';
import 'package:stellar_explorer/services/api_constants.dart';

class ApiServices {
  // For NASA API Service
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      queryParameters: {
        "api_key" : ApiConstants.apiKey
      }
    ) 
  );

  // For The Solar System OpenData API Service
  final Dio dioForPlanetsData = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrlForPlanetsData,
      headers: {
        "Authorization" : "Bearer ${ApiConstants.apiKeyForPlanetsData}",
        "accept" : "application/json"
      }
    )
  );

  // For NASA Image Library and ISS Tracker beacuse these 2 API Services doesn't require any api key or authorization.
  final Dio plainDio = Dio();

  // Astronomy Picture of the Day
  Future <ApodModel> getAPOD () async {
    try {
      final response = await dio.get("/planetary/apod");
      return ApodModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception("No Internet Connection");
      } else {
        throw Exception("Server Error: ${e.response?.statusCode}");
      }
    }
    catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }
  
  // NASA Image Library
  Future <List<NasaImagesModel>> getNASAImages (String query) async {
    try {      
      final response = await plainDio.get(
        "https://images-api.nasa.gov/search",
        queryParameters: {
          "q" : query,
          "media_type" : "image" // get images only
        }
      );
      final List items = response.data["collection"]["items"] ?? [];
      List<NasaImagesModel> imageList = items.map((jsonItem) {
        return NasaImagesModel.fromJson(jsonItem);
      }).toList();
      return imageList;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception("No Internet Connection");
      } else {
        throw Exception("Server Error: ${e.response?.statusCode}");
      }
    }
    catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }

  // Asteroids
  Future <List<AsteroidsModel>> getAsteroidsData () async {
    try {
      final response = await dio.get("/neo/rest/v1/feed");
      final Map<String,dynamic> nearEarthObjects = response.data["near_earth_objects"]; // Extracting near_earth_objects Map from JSON.
      List<AsteroidsModel> allAsteroids = [];
      nearEarthObjects.forEach((datakey, asteroidsList) {
        for (var asteroidJson in asteroidsList) {
          allAsteroids.add(AsteroidsModel.fromJson(asteroidJson));
        }
      });
      return allAsteroids;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception("No Internet Connection");
      } else {
        throw Exception("Server Error: ${e.response?.statusCode}");
      }
    }
    catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }

  // ExoPlaents
  Future <List<ExoplanetsModel>> getExoPlanetsData () async {
    try {
      final response = await dio.get(
        "https://exoplanetarchive.ipac.caltech.edu/TAP/sync?query=select+top+15+*+from+pscomppars+where+pl_masse+is+not+null&format=json",
      );

      List<dynamic> rawData = response.data;

      List <ExoplanetsModel> planetsList = rawData.map((planetJson) {
        return ExoplanetsModel.fromJson(planetJson);
      }).toList();

      return planetsList;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception("No Internet Connection");
      } else {
        throw Exception("Server Error: ${e.response?.statusCode}");
      }
    }
    catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }

  // Space Weather
  Future <List<SpaceWeatherModel>> getSpaceWeatherData () async {
    try {
      final response = await dio.get("https://api.nasa.gov/DONKI/CME");
      List<dynamic> rawData = response.data;
      List <SpaceWeatherModel> spaceWeatherData = rawData.map((weatherJson) {
        return SpaceWeatherModel.fromJson(weatherJson);
      }).toList();
      return spaceWeatherData;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception("No Internet Connection");
      } else {
        throw Exception("Server Error: ${e.response?.statusCode}");
      }
    }
    catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }

  // Planets Data
  Future <PlanetsModel> getPlanetsData (String id) async {
    try {
      final response = await dioForPlanetsData.get("bodies/$id");
      return PlanetsModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception("No Internet Connection");
      } else {
        throw Exception("Server Error: ${e.response?.statusCode}");
      }
    }
    catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }

  // ISS Tracker
  Future <IssModel> trackISS () async {
    try {
      final response = await plainDio.get("https://api.wheretheiss.at/v1/satellites/25544");
      return IssModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception("No Internet Connection");
      } else {
        throw Exception("Server Error: ${e.response?.statusCode}");
      }
    }
    catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }

  // Space News
  Future<List<SpaceNewsModel>> getSpaceNews () async {
    try {
      final response = await plainDio.get("https://api.spaceflightnewsapi.net/v4/articles/");
      final List <dynamic> rawNewsList = response.data["results"];
      List<SpaceNewsModel> spaceNewsList = rawNewsList.map((json) => SpaceNewsModel.fromJson(json)).toList();
      return spaceNewsList;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception("No Internet Connection");
      } else {
        throw Exception("Server Error: ${e.response?.statusCode}");
      }
    }
    catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }

  // Space News Search
  Future<List<SpaceNewsModel>> searchSpaceNews(String query) async {
    try {
      final response = await plainDio.get("https://api.spaceflightnewsapi.net/v4/articles/?search=$query");
      final List<dynamic> rawNewsList = response.data["results"];
      List<SpaceNewsModel> searchResults = rawNewsList.map((json) => SpaceNewsModel.fromJson(json)).toList();
      return searchResults;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception("No Internet Connection");
      } else {
        throw Exception("Server Error: ${e.response?.statusCode}");
      }
    } catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }

  // Launches
  Future<List<LaunchesModel>> getLaunchesData () async {
    try {
      final response = await plainDio.get("https://lldev.thespacedevs.com/2.2.0/launch/upcoming/");
      final List <dynamic> rawData= response.data["results"];
      List<LaunchesModel> launchesList = rawData.map((json) => LaunchesModel.fromJson(json)).toList();
      return launchesList;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception("No Internet Connection");
      } else {
        throw Exception("Server Error: ${e.response?.statusCode}");
      }
    }
    catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }

  // Missions 
  Future<List<LaunchesModel>> getMissionsData() async {
    try {
      final response = await plainDio.get("https://lldev.thespacedevs.com/2.2.0/launch/previous/");
      final List<dynamic> rawData = response.data["results"];
      List<LaunchesModel> missionsList = rawData.map((json) => LaunchesModel.fromJson(json)).toList();
      return missionsList;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception("No Internet Connection");
      } else {
        throw Exception("Server Error: ${e.response?.statusCode}");
      }
    } catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }
}