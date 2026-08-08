import 'package:flutter/material.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class NasaImagesScreen extends StatefulWidget {
  const NasaImagesScreen({super.key});

  @override
  State <NasaImagesScreen> createState() => _NasaImagesScreenState();
}

class _NasaImagesScreenState extends State <NasaImagesScreen> {
  final List<Map<String, dynamic>> nasaImages = const [
    {"title" : "Pillars of Creation", "image" : "assets/images/Galaxy.jpg"},
    {"title" : "Pillars of Creation", "image" : "assets/images/Galaxy.jpg"},
    {"title" : "Pillars of Creation", "image" : "assets/images/Galaxy.jpg"},
    {"title" : "Pillars of Creation", "image" : "assets/images/Galaxy.jpg"},
    {"title" : "Pillars of Creation", "image" : "assets/images/Galaxy.jpg"},
    {"title" : "Pillars of Creation", "image" : "assets/images/Galaxy.jpg"},
    {"title" : "Pillars of Creation", "image" : "assets/images/Galaxy.jpg"},
    {"title" : "Pillars of Creation", "image" : "assets/images/Galaxy.jpg"},
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
          "NASA Images",
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
          itemCount: nasaImages.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8
          ),
          itemBuilder: (context, index) {
            final image = nasaImages[index];
            return InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: ColorPalettes.subTextGray.withValues(alpha: 0.2), width: 1),
                  image: DecorationImage(
                    image: AssetImage(image["image"]),
                    fit: BoxFit.cover
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Text(
                          image["title"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: ColorPalettes.primaryWhite
                          ),
                        ),

                        const Spacer(),

                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: ColorPalettes.subTextGray,
                          size: 14,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}