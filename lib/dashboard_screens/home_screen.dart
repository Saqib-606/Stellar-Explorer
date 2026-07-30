import 'package:flutter/material.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State <HomeScreen> createState () => _HomeScreenState();
}

class _HomeScreenState extends State <HomeScreen> {
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // Gives a iOS-style bounce effect
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.star, color: ColorPalettes.primaryWhite,),
          
                  const Icon(Icons.notifications_rounded, color: ColorPalettes.primaryWhite,)
                ],
              ),
                
              const SizedBox(height: 15,),
                
              const Text(
                "Stellar Explorer",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: ColorPalettes.primaryWhite
                ),
              ),
                
              const Text(
                "Explore the Universe",
                style: TextStyle(
                  fontSize: 15,
                  color: ColorPalettes.subTextGray
                ),
              ),
                
              const SizedBox(height: 15,),
                
              Container(
                height: MediaQuery.of(context).size.height * 0.28,
                width: double.infinity,  
                clipBehavior: Clip.antiAlias, // So that image doesn't go out of the border/container
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: ColorPalettes.subTextGray.withValues(alpha: 0.2), 
                    width: 0.5
                  ),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/Galaxy.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent, 
                        ColorPalettes.mainBackground.withValues(alpha: 0.9), 
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15,),
                        child: const Text(
                          "Astronomy Picture of the Day",
                          style: TextStyle(
                            color: ColorPalettes.primaryWhite, 
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                
                      const Spacer(), 
                
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Spiral Galaxy NGC 1300",
                                  style: TextStyle(
                                    color: ColorPalettes.primaryWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                
                                const SizedBox(height: 4,), 
                
                                Text(
                                  "May 18, 2024",
                                  style: TextStyle(
                                    color: ColorPalettes.subTextGray,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                
                            const Spacer(),
                
                            CircleAvatar(
                              backgroundColor: ColorPalettes.cardBackground, 
                              radius: 16,
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: ColorPalettes.primaryWhite,
                                size: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
                
              const SizedBox(height: 15,),

              const Text(
                "Explore",
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold, 
                  color: ColorPalettes.primaryWhite,
                  letterSpacing: 0.5

                ),
              ),
                
              const SizedBox(height: 10,),

              GridView.builder(
                itemCount: exploreItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final item = exploreItems[index];
                  return InkWell(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: ColorPalettes.cardBackground,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Image.asset(
                              item["image"],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),

                          const SizedBox(height: 5,),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 6.0),
                            child: Text(
                              item["title"],
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: ColorPalettes.primaryWhite,
                                fontSize: 10,
                                height: 1.1
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
                
              const SizedBox(height: 15,),
                
              const Text(
                "Today's Highlights",
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold, 
                  color: ColorPalettes.primaryWhite,
                  letterSpacing: 0.5
                ),
              ),
                
              const SizedBox(height: 10,),
        
              Container(
                width: double.infinity,
                height: 115,
                clipBehavior: Clip.antiAlias, 
                decoration: BoxDecoration(
                  color: ColorPalettes.cardBackground,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: ColorPalettes.subTextGray.withValues(alpha: 0.2), 
                    width: 1
                  )
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("ISS Above You", style: TextStyle(color: ColorPalettes.primaryWhite),),
                          
                          const SizedBox(height: 5,),
                      
                          Text("Next Pass in 42 Mints", style: TextStyle(color: ColorPalettes.primaryWhite),),
                      
                          const SizedBox(height: 8,),
                      
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorPalettes.cardBackground,
                                shadowColor: ColorPalettes.primaryWhite,
                                side: BorderSide(
                                  color: ColorPalettes.subTextGray.withValues(alpha: 0.2), 
                                  width: 0.8
                                )
                              ),
                              onPressed: () {},
                              child: const Text("View", style: TextStyle(color: ColorPalettes.primaryWhite),),
                            ),
                          )
                        ],
                      ),
                    ),
                      
                    Spacer(),
                      
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "assets/images/Earth.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}