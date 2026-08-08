import 'package:flutter/material.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class ExoplanetsScreen extends StatefulWidget {
  const ExoplanetsScreen({super.key});

  @override
  State<ExoplanetsScreen> createState() => _ExoplanetsScreenState();
}

class _ExoplanetsScreenState extends State<ExoplanetsScreen> {
  final List<Map<String, dynamic>> exoPlanetsData = const [
    {
      "image": "assets/images/Exoplanets.jpg",
      "title": "Kepeler-452B",
      "type": "Earth-like",
      "distance": "~1,400 light years away",
      "diameter" : "1.6 Earth Radii"
    },
    {
      "image": "assets/images/Exoplanets.jpg",
      "title": "Kepeler-452B",
      "type": "Earth-like",
      "distance": "~1,400 light years away",
      "diameter" : "1.6 Earth Radii"
    },
    {
      "image": "assets/images/Exoplanets.jpg",
      "title": "Kepeler-452B",
      "type": "Earth-like",
      "distance": "~1,400 light years away",
      "diameter" : "1.6 Earth Radii"
    },
    {
      "image": "assets/images/Exoplanets.jpg",
      "title": "Kepeler-452B",
      "type": "Earth-like",
      "distance": "~1,400 light years away",
      "diameter" : "1.6 Earth Radii"
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
          "Exoplanets",
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
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Discover Worlds",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: ColorPalettes.primaryWhite,
                              ),
                            ),
                        
                            const SizedBox(height: 8,),
                        
                            const Text(
                              "Explore planets beyond our solar system. Who knows what we might find?",
                              style: TextStyle(
                                fontSize: 12,
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
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(14), bottomRight: Radius.circular(14)),
                        child: Image.asset(
                          "assets/images/Exoplanets.jpg",
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 10,),

              const SizedBox(height: 20,),
        
              ListView.builder(
                itemCount: exoPlanetsData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final exoPlanet = exoPlanetsData[index];
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
                                  exoPlanet["image"],
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
                                      exoPlanet["title"],
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
                                        exoPlanet["type"],
                                        style: TextStyle(color: Colors.greenAccent),
                                      ),
                                    )
                                  ],
                                ),
                      
                                const SizedBox(height: 5,),
                                    
                                Text(
                                  exoPlanet["distance"],
                                  style: TextStyle(color: ColorPalettes.subTextGray),
                                ),
                              
                                const SizedBox(height: 20,),
                      
                                Text(
                                  exoPlanet["diameter"],
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
              ),

              const SizedBox(height: 10,), 
            ],
          ),
        ),
      ),
    );
  }
}