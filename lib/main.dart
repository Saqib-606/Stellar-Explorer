import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stellar_explorer/provider/earth_watch_provider.dart';
import 'package:stellar_explorer/provider/iss_location_provider.dart';
import 'package:stellar_explorer/provider/iss_provider.dart';
import 'package:stellar_explorer/provider/launches_provider.dart';
import 'package:stellar_explorer/provider/mission_provider.dart';
import 'package:stellar_explorer/provider/planets_provider.dart';
import 'package:stellar_explorer/provider/asteroids_provider.dart';
import 'package:stellar_explorer/provider/exoplanets_provider.dart';
import 'package:stellar_explorer/provider/navigation_provider.dart';
import 'package:stellar_explorer/provider/apod_provider.dart';
import 'package:stellar_explorer/provider/nasa_image_provider.dart';
import 'package:stellar_explorer/provider/space_news_provider.dart';
import 'package:stellar_explorer/provider/space_weather_provider.dart';
import 'package:stellar_explorer/screens/splash_screen/splash_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider( 
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => ApodProvider()),
        ChangeNotifierProvider(create: (context) => NasaImageProvider()),
        ChangeNotifierProvider(create: (context) => AsteroidsProvider()),
        ChangeNotifierProvider(create: (context) => ExoplanetsProvider()),
        ChangeNotifierProvider(create: (context) => SpaceWeatherProvider()),
        ChangeNotifierProvider(create: (context) => PlanetsProvider()),
        ChangeNotifierProvider(create: (context) => IssProvider()),
        ChangeNotifierProvider(create: (context) => IssLocationProvider()),
        ChangeNotifierProvider(create: (context) => SpaceNewsProvider()),
        ChangeNotifierProvider(create: (context) => LaunchesProvider()),
        ChangeNotifierProvider(create: (context) => MissionProvider()),
        ChangeNotifierProvider(create: (context) => EarthWatchProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData( // To remove flutter default Bottom Navigation Bar Effect
          splashFactory: NoSplash.splashFactory,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent
        ),
        home: const SplashScreen(),
      ),
    );
  }
}