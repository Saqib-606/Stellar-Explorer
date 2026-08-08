import 'package:flutter/material.dart';
import 'package:stellar_explorer/screens/sub_screens/asteroids_screen.dart';
import 'package:stellar_explorer/screens/sub_screens/exoplanets_screen.dart';
import 'package:stellar_explorer/screens/sub_screens/iss_tracker_screen.dart';
import 'package:stellar_explorer/screens/sub_screens/launches_screen.dart';
import 'package:stellar_explorer/screens/sub_screens/missions_screen.dart';
import 'package:stellar_explorer/screens/sub_screens/nasa_images_screen.dart';
import 'package:stellar_explorer/screens/sub_screens/planets_screen.dart';
import 'package:stellar_explorer/screens/sub_screens/space_weather_screen.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State <ExploreScreen> createState () => _ExploreScreenState();
}

class _ExploreScreenState extends State <ExploreScreen> {
  final List<Map<String, dynamic>> stellarFeatures = [
    {
      "title": "ISS Tracker",
      "image": "assets/images/ISS.jpg",
      "screenBuilder": () => const IssTrackerScreen(),
    },
    {
      "title": "Planets",
      "image": "assets/images/Saturn.jpg",
      "screenBuilder": () => const PlanetsScreen(),
    },
    {
      "title": "Asteroids",
      "image": "assets/images/Asteroids.jpg",
      "screenBuilder": () => const AsteroidsScreen(),
    },
    {
      "title": "Exoplanets",
      "image": "assets/images/Exoplanets.jpg",
      "screenBuilder": () => const ExoplanetsScreen(),
    },
    {
      "title": "NASA Images",
      "image": "assets/images/Galaxy.jpg",
      "screenBuilder": () => const NasaImagesScreen(),
    },
    {
      "title": "Space Weather",
      "image": "assets/images/Space Weather.jpg",
      "screenBuilder": () => const SpaceWeatherScreen(),
    },
    {
      "title": "Launches",
      "image": "assets/images/Launch.jpg",
      "screenBuilder": () => const LaunchesScreen(),
    },
    {
      "title": "Missions",
      "image": "assets/images/mission.jpg",
      "screenBuilder": () => const MissionsScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.mainBackground,
      appBar: AppBar(
        backgroundColor: ColorPalettes.mainBackground,
        elevation: 0,
        scrolledUnderElevation: 0,  // To remove or stop app bar default shadow while scrolling.
        title: const Text(
          "Explore",
          style: TextStyle(
            color: ColorPalettes.primaryWhite,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), 
          child: Column(
            children: [
              GridView.builder(
                itemCount: stellarFeatures.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8
                ),
                itemBuilder: (context, index) {
                  final feature = stellarFeatures[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => feature["screenBuilder"](),
                      ));
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias, 
                      decoration: BoxDecoration(
                        color: ColorPalettes.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 9,
                            child: Image.asset(
                              feature["image"],
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ),
                    
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    ColorPalettes.mediumGray
                                  ]
                                )
                              ),
                              child: Center(
                                child: Text(
                                  feature["title"],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: ColorPalettes.primaryWhite
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}