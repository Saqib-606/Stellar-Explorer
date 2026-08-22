import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stellar_explorer/provider/apod_provider.dart';
import 'package:stellar_explorer/screens/detail_screens/astronomy_picture_detail_screen.dart';
import 'package:stellar_explorer/screens/sub_screens/asteroids_screen.dart';
import 'package:stellar_explorer/screens/sub_screens/exoplanets_screen.dart';
import 'package:stellar_explorer/screens/sub_screens/iss_tracker_screen.dart';
import 'package:stellar_explorer/screens/sub_screens/launches_screen.dart';
import 'package:stellar_explorer/screens/sub_screens/missions_screen.dart';
import 'package:stellar_explorer/screens/sub_screens/nasa_images_screen.dart';
import 'package:stellar_explorer/screens/sub_screens/planets_screen.dart';
import 'package:stellar_explorer/screens/sub_screens/space_weather_screen.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State <HomeScreen> createState () => _HomeScreenState();
}

class _HomeScreenState extends State <HomeScreen> {
  final List<Map<String, dynamic>> quickAccessItems = [ 
    {
      "title": "ISS Tracker",
      "image": "assets/images/ISS.jpg",
      "screenBuilder": () => const IssTrackerScreen(), // () => means create screen only on user tap
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ApodProvider>().fetchAPOD();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.mainBackground,
      body: RefreshIndicator(
        color: ColorPalettes.primaryWhite,
        backgroundColor: ColorPalettes.mainBackground,
        onRefresh: () async {
          await context.read<ApodProvider>().refreshAPOD();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(  // Placing AlwaysScrollable is necessary for Refresh Indicator widget.
            parent: BouncingScrollPhysics()  // Gives a iOS-style bounce effect
          ),
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
                  
                Consumer<ApodProvider>(
                  builder: (context, provider, child) {
                    final data = provider.apodData;
                    final isImage = data != null && data.mediaType == "image";
                    final imageUrl = isImage ? data.url : "assets/images/Galaxy.jpg";
        
                    if (provider.loading) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.28,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorPalettes.cardBackground,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: ColorPalettes.primaryWhite,
                          ),
                        ),
                      );
                    }
        
                    if (provider.errorMessage.isNotEmpty) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.28,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorPalettes.cardBackground,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  provider.errorMessage,
                                  style: const TextStyle(color: Colors.redAccent),
                                  textAlign: TextAlign.center,
                                ),
        
                                const SizedBox(height: 10,),
        
                                const Text(
                                  "Pull down to refresh ⬇️",
                                  style: TextStyle(color: ColorPalettes.subTextGray, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
        
                      );
                    }
                    
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AstronomyPictureDetailScreen(apodData: data!,),
                        ));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.28,
                        width: double.infinity,  
                        clipBehavior: Clip.antiAlias, // So that image doesn't go out of the border/container
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: ColorPalettes.subTextGray.withValues(alpha: 0.2), 
                            width: 0.5
                          ),
                          image: DecorationImage(
                            image: (data?.mediaType == "image") ? NetworkImage(imageUrl) as ImageProvider : AssetImage(imageUrl),
                            fit: BoxFit.cover
                          )
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
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                        
                              const Spacer(), 
                        
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data?.title ?? "No Title",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: ColorPalettes.primaryWhite,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                                          
                                          const SizedBox(height: 4,), 
                                                          
                                          Text(
                                            data?.date ?? "No Date",
                                            style: TextStyle(
                                              color: ColorPalettes.subTextGray,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                        
                                    const SizedBox(width: 15),
                        
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
                    );
                  }
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
                  itemCount: quickAccessItems.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final item = quickAccessItems[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => item["screenBuilder"](),
                        ));
                      },
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
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => IssTrackerScreen(),
                                  ));
                                },
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
      ),
    );
  }
}