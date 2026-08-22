import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stellar_explorer/provider/space_weather_provider.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class SpaceWeatherScreen extends StatefulWidget {
  const SpaceWeatherScreen({super.key});

  @override
  State<SpaceWeatherScreen> createState() => _SpaceWeatherScreenState();
}

class _SpaceWeatherScreenState extends State<SpaceWeatherScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SpaceWeatherProvider>().fetchSpaceWeatherData();
    });
  }

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
          "Space Weather",
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), bottomLeft: Radius.circular(14)),
                        child: Image.asset(
                          "assets/images/Space Weather.jpg",
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Current Conditions",
                              style: TextStyle(
                                color: ColorPalettes.primaryWhite,
                              ),
                            ),
                        
                            const SizedBox(height: 8,),
                          
                            const Text(
                              "Active",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent,
                                letterSpacing: 1.1
                              ),
                            ),

                            const SizedBox(height: 8,),

                            const Text(
                              "CME Data Tracked",
                              style: TextStyle(
                                color: ColorPalettes.primaryWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 15,),

              const Text(
                "Recent Solar Storms (CME)",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorPalettes.primaryWhite,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 10,),

              Consumer<SpaceWeatherProvider>(
                builder: (context, provider, child) {
                  if (provider.loading) {
                    return Center(child: const CircularProgressIndicator(color: ColorPalettes.primaryWhite,),);
                  }

                  if (provider.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(
                        provider.errorMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16,
                        ),
                      ),
                    );
                  } 

                  if (provider.spaceWeather.isEmpty) {
                    return const Center(
                      child: Text(
                        "No recent solar storms reported.",
                        style: TextStyle(color: ColorPalettes.primaryWhite),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: provider.spaceWeather.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final weatherEvent = provider.spaceWeather[index];                      
                      String stormSpeed = "Unknown Speed";

                      if(weatherEvent.cmeAnalyses.isNotEmpty) {
                        stormSpeed = "${weatherEvent.cmeAnalyses[0]['speed'] ?? 'N/A'} km/s";
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            color: ColorPalettes.cardBackground,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: ColorPalettes.subTextGray.withValues(alpha: 0.15), width: 1)
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Location: ${weatherEvent.sourceLocation}",
                                      style: const TextStyle(color: ColorPalettes.primaryWhite, fontSize: 15, fontWeight: FontWeight.bold),
                                    ),

                                    const SizedBox(height: 4),
                                    
                                    Text(
                                      "Time: ${weatherEvent.startTime} • Speed: $stormSpeed",
                                      style: const TextStyle(color: Colors.tealAccent, fontSize: 12, fontWeight: FontWeight.w500),
                                    ),

                                    const SizedBox(height: 6),

                                    Text(
                                      weatherEvent.note.isEmpty ? "No detailed note provided by NASA for this event." : weatherEvent.note,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: ColorPalettes.subTextGray, fontSize: 12, height: 1.3),
                                    ),                              
                                  ],
                                ),
                              ),
                              
                              const SizedBox(width: 15),
                              
                              Icon(
                                Icons.local_fire_department_rounded,
                                color: weatherEvent.cmeAnalyses.isNotEmpty ? Colors.redAccent : Colors.orangeAccent,
                                size: 35,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              ),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}