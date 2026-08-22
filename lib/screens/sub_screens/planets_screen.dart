import 'package:flutter/material.dart';
import 'package:stellar_explorer/screens/detail_screens/planet_detail_screen.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class PlanetsScreen extends StatefulWidget {
  const PlanetsScreen({super.key});

  @override
  State <PlanetsScreen> createState() => _PlanetsScreenState();
}

class _PlanetsScreenState extends State <PlanetsScreen> {
  final List<Map<String, dynamic>> planets = const [
    {
      "id" : "mercury",
      "title": "Mercury",
      "subtitle": "The Smallest Planet",
      "image": "assets/images/Mercury.png",
    },
    {
      "id" : "venus",
      "title": "Venus",
      "subtitle": "The Hottest Planet",
      "image": "assets/images/Venus.png",
    },
    {
      "id" : "earth",
      "title": "Earth",
      "subtitle": "Our Home",
      "image": "assets/images/ISS Earth.png",
    },
    {
      "id" : "mars",
      "title": "Mars",
      "subtitle": "The Red Planet",
      "image": "assets/images/Mars without background.png",
    },
    {
      "id" : "jupiter",
      "title": "Jupiter",
      "subtitle": "The Largest Planet",
      "image": "assets/images/Jupiter.png",
    },
    {
      "id" : "saturn",
      "title": "Saturn",
      "subtitle": "The Ringed Planet",
      "image": "assets/images/Saturn without background.png",
    },
    {
      "id" : "uranus",
      "title": "Uranus",
      "subtitle": "The Ice Gaint",
      "image": "assets/images/Uranus.png",
    },
    {
      "id" : "neptune",
      "title": "Neptune",
      "subtitle": "The Farthest Planet",
      "image": "assets/images/Neptune.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.mainBackground,
      appBar: AppBar(
        backgroundColor: ColorPalettes.mainBackground,
        elevation: 0,
        scrolledUnderElevation: 0,  
        iconTheme: const IconThemeData(color: ColorPalettes.primaryWhite),
        title: const Text(
          "Planets",
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
        child: ListView.builder(
          itemCount: planets.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final planet = planets[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PlanetDetailScreen(id: planet["id"]),
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorPalettes.cardBackground,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        planet["image"],
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                
                      SizedBox(width: 7,),
                
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            planet["title"],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorPalettes.primaryWhite
                            ),
                          ),
                
                          Text(
                            planet["subtitle"],
                            style: TextStyle(
                              color: ColorPalettes.subTextGray
                            ),
                          )
                
                        ],
                      ),
                
                      const Spacer(),
                
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(Icons.arrow_forward_ios_rounded, color: ColorPalettes.subTextGray, size: 14,),
                      )
                    ],
                  ),
                ),
              ),
            );            
          },
        )
      ),
    );
  }
}