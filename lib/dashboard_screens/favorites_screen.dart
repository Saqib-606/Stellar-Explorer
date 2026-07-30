import 'package:flutter/material.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State <FavoritesScreen> createState () => _FavoritesScreenState();
}

class _FavoritesScreenState extends State <FavoritesScreen> {
  final List<Map<String, dynamic>> exploreItems = const [
    {"title": "ISS Tracker", "image": "assets/images/ISS.jpg"},
    {"title": "Planets", "image": "assets/images/Saturn.jpg"},
    {"title": "Asteroids", "image": "assets/images/Asteroids.jpg"},
    {"title": "Mars Weather", "image": "assets/images/Mars.png"},
    {"title": "NASA Images", "image": "assets/images/Galaxy.jpg"},
    {"title": "Space News", "image": "assets/images/News.png"},
    {"title": "Launches", "image": "assets/images/Launch.jpg"},
    {"title": "Missions", "image": "assets/images/mission.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.mainBackground,
      appBar: AppBar(
        backgroundColor: ColorPalettes.mainBackground,
        elevation: 0,
        scrolledUnderElevation: 0, 
        title: const Text(
          "Favorites",
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
        child: GridView.builder(
          itemCount: exploreItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            childAspectRatio: 0.55
          ),
          itemBuilder: (context, index) {
            final item = exploreItems[index];
            return InkWell(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 160,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(15),
                      child: Image.asset(
                        item["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              
                  const SizedBox(height: 10,),
              
                  SizedBox(
                    width: 100,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        item["title"],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: ColorPalettes.primaryWhite
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}