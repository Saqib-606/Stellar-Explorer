import 'package:flutter/material.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class AsteroidsScreen extends StatefulWidget {
  const AsteroidsScreen({super.key});

  @override
  State <AsteroidsScreen> createState() => _AsteroidsScreenState();
}

class _AsteroidsScreenState extends State <AsteroidsScreen> {
  // Dummy Data
  final List<Map<String, dynamic>> asteroidsData = const [
    {
      "title": "2024 YR4",
      "warning": "SAFE",
      "date": "May 20, 2024 . 03:42 AM",
      "distance": "2.17 Lunar Distances",
      "image": "assets/images/Asteroids.jpg",
    },
    {
      "title": "2024 JG2",
      "warning": "MODERATE",
      "date": "May 21, 2024 . 11:16 PM",
      "distance": "4.35 Lunar Distances",
      "image": "assets/images/Asteroids.jpg",
    },
    {
      "title": "2024 HV5",
      "warning": "SAFE",
      "date": "May 24, 2024 . 06:27 PM",
      "distance": "3.02 Lunar Distances",
      "image": "assets/images/Asteroids.jpg",
    },
    {
      "title": "2024 KF",
      "warning": "SAFE",
      "date": "May 24, 2024 . 09:11 AM",
      "distance": "1.64 Lunar Distances",
      "image": "assets/images/Asteroids.jpg",
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
          "Asteroids",
          style: TextStyle(
            color: ColorPalettes.primaryWhite,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), 
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: ColorPalettes.cardBackground,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: ColorPalettes.subTextGray.withValues(alpha: 0.2), width: 1)
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Near Earth Asteroids",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: ColorPalettes.primaryWhite,
                              ),
                            ),
                        
                            const SizedBox(height: 8,),
                        
                            const Text(
                              "Track asteroids that pass close to Earth.",
                              style: TextStyle(
                                color: ColorPalettes.subTextGray
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                              
                    Expanded(
                      flex: 6,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(14)),
                        child: Image.asset(
                          "assets/images/Asteroids.jpg",
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                    )
                  ],
                ),
              ),
        
              const SizedBox(height: 20,),
        
              ListView.builder(
                itemCount: asteroidsData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final asteroidData = asteroidsData[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: ColorPalettes.cardBackground,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  asteroidData["image"],
                                  fit: BoxFit.cover,
                                  height: 120,
                                  width: 100,
                                ),
                              ),
                            ),
                                    
                            const SizedBox(width: 5,),
                      
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      asteroidData["title"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ColorPalettes.primaryWhite
                                      ),
                                    ),
                                    
                                    const SizedBox(width: 10,),
                      
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.greenAccent, width: 1)
                                      ),
                                      child: Text(
                                        asteroidData["warning"],
                                        style: TextStyle(color: Colors.greenAccent),
                                      ),
                                    )
                                  ],
                                ),
                      
                                const SizedBox(height: 5,),
                                    
                                Text(
                                  asteroidData["date"],
                                  style: TextStyle(color: ColorPalettes.subTextGray),
                                ),
                              
                                const SizedBox(height: 10,),
                      
                                const Text(
                                  "Distance from Earth",
                                  style: TextStyle(
                                    color: ColorPalettes.subTextGray
                                  ),
                                ),
                                    
                                Text(
                                  asteroidData["distance"],
                                  style: TextStyle(
                                    color: ColorPalettes.primaryWhite,
                                    fontSize: 16,
                                  )
                                )
                              ],
                            ),
                      
                            const Spacer(),
                      
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: ColorPalettes.subTextGray,
                                size: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )        
            ],
          ),
        ),
      ),
    );
  }
}