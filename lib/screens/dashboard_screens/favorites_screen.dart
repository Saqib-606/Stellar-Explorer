import 'package:flutter/material.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<Map<String, dynamic>> favoriteItems = const [
    {
      "title": "Saturn",
      "subtitle": "Ringed Giant",
      "image": "assets/images/Saturn.jpg",
      "type": "PLANET",
      "icon": Icons.public_rounded
    },
    {
      "title": "Artemis 2 Mission Delayed due to Booster Issues",
      "subtitle": "Source: SpaceNews",
      "image": "assets/images/Launch.jpg",
      "type": "NEWS",
      "icon": Icons.article_rounded
    },
    {
      "title": "Falcon 9 Launch",
      "subtitle": "Cape Canaveral",
      "image": "assets/images/Launch.jpg",
      "type": "LAUNCH",
      "icon": Icons.rocket_launch_rounded
    },
    {
      "title": "Spiral Galaxy NGC 1300",
      "subtitle": "APOD May 18",
      "image": "assets/images/Galaxy.jpg",
      "type": "IMAGE",
      "icon": Icons.satellite_alt_rounded
    },
  ];

  // Helper Function
  IconData getIconForType(String type) {
    switch (type.toUpperCase()) {
      case 'PLANET':
        return Icons.public_rounded;
      case 'NEWS':
        return Icons.article_rounded;
      case 'LAUNCH':
        return Icons.rocket_launch_rounded;
      case 'IMAGE':
        return Icons.satellite_alt_rounded;
      default:
        return Icons.star_rounded; // Default icon 
    }
  }

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
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: favoriteItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12, 
            mainAxisSpacing: 12,
            childAspectRatio: 0.75, 
          ),
          itemBuilder: (context, index) {
            final item = favoriteItems[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorPalettes.cardBackground,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), 
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                item["image"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6), 
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    getIconForType(item["type"]),
                                    color: ColorPalettes.primaryWhite,
                                    size: 16, // Chota icon
                                  ),

                                  const SizedBox(height: 2),

                                  Text(
                                    item["type"],
                                    style: const TextStyle(
                                      color: ColorPalettes.primaryWhite,
                                      fontSize: 8, // Tiny text
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["title"],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: ColorPalettes.primaryWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                        ),

                        const SizedBox(height: 6),
                        
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item["subtitle"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: ColorPalettes.subTextGray,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              color: ColorPalettes.subTextGray,
                              size: 16,
                            )
                          ],
                        )
                      ],
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