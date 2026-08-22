import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stellar_explorer/provider/asteroids_provider.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class AsteroidsScreen extends StatefulWidget {
  const AsteroidsScreen({super.key});

  @override
  State<AsteroidsScreen> createState() => _AsteroidsScreenState();
}

class _AsteroidsScreenState extends State<AsteroidsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AsteroidsProvider>().fetchAsteroidsData();
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
          "Asteroids",
          style: TextStyle(
            color: ColorPalettes.primaryWhite,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
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
                  border: Border.all(
                    color: ColorPalettes.subTextGray.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 7,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Near Earth Asteroids",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: ColorPalettes.primaryWhite,
                              ),
                            ),

                            SizedBox(height: 8),

                            Text(
                              "Track real-time data of asteroids passing close to Earth.",
                              style: TextStyle(
                                color: ColorPalettes.subTextGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 6,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(14),
                          bottomRight: Radius.circular(14),
                        ),
                        child: Image.asset(
                          "assets/images/Asteroids.jpg",
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Consumer<AsteroidsProvider>(
                builder: (context, provider, child) {
                  if (provider.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorPalettes.primaryWhite,
                      ),
                    );
                  }

                  if (provider.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(
                        provider.errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }

                  if (provider.asteroidsList.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Asteroids Data Available",
                        style: TextStyle(color: ColorPalettes.primaryWhite),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: provider.asteroidsList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final asteroid = provider.asteroidsList[index];
                  
                      // Safe data extraction from nested lists
                      String date = "Unknown Date";
                      String distance = "Unknown Distance";
                  
                      if (asteroid.closeApproachData.isNotEmpty) {
                        date = asteroid.closeApproachData[0]["close_approach_date"] ?? date;
                        String rawDistance = asteroid .closeApproachData[0]["miss_distance"]["kilometers"] ?? "0";
                        double distInKm = double.tryParse(rawDistance) ?? 0.0;
                  
                        if (distInKm >= 1000000) {
                          distance = "${(distInKm / 1000000).toStringAsFixed(2)}M km";
                        } else {
                          distance = "${distInKm.toStringAsFixed(0)} km";
                        }
                      }
                  
                      bool isDanger = asteroid.isHazardous;
                  
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: ColorPalettes.cardBackground,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: ColorPalettes.subTextGray.withValues(alpha: 0.1,), width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        asteroid.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: ColorPalettes.primaryWhite,
                                        ),
                                      ),
                                    ),
                  
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4,),
                                      decoration: BoxDecoration(
                                        color: isDanger ? Colors.red.withValues(alpha: 0.15) : Colors.green.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: isDanger ? Colors.redAccent : Colors.greenAccent, width: 1,),
                                      ),
                                      child: Text(
                                        isDanger ? "HAZARDOUS" : "SAFE",
                                        style: TextStyle(
                                          color: isDanger ? Colors.redAccent : Colors.greenAccent,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                  
                                const SizedBox(height: 12),
                  
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today_rounded,
                                      size: 14,
                                      color: ColorPalettes.subTextGray,
                                    ),
                  
                                    const SizedBox(width: 5),
                  
                                    Text(
                                      date,
                                      style: const TextStyle(
                                        color: ColorPalettes.subTextGray,
                                        fontSize: 13,
                                      ),
                                    ),
                  
                                    const Spacer(),
                  
                                    const Icon(
                                      Icons.light_mode_rounded,
                                      size: 14,
                                      color: ColorPalettes.subTextGray,
                                    ),
                  
                                    const SizedBox(width: 5),
                  
                                    Text(
                                      "Mag: ${asteroid.absoluteMagnitude}",
                                      style: const TextStyle(
                                        color: ColorPalettes.subTextGray,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                  
                                const SizedBox(height: 8),
                  
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.space_dashboard_rounded,
                                      size: 14,
                                      color: ColorPalettes.subTextGray,
                                    ),
                  
                                    const SizedBox(width: 5),
                  
                                    Text(
                                      "Distance: $distance",
                                      style: const TextStyle(
                                        color: ColorPalettes.primaryWhite,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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