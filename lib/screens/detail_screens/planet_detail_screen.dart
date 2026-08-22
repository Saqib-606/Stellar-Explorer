import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stellar_explorer/provider/planets_provider.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class PlanetDetailScreen extends StatefulWidget {
  final String id;
  const PlanetDetailScreen({super.key, required this.id});

  @override
  State<PlanetDetailScreen> createState() => _PlanetDetailScreenState();
}

class _PlanetDetailScreenState extends State<PlanetDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlanetsProvider>().fetchPlanetData(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.mainBackground,
      body: Consumer<PlanetsProvider>(
        builder: (context, provider, child) {
          final planet = provider.planetData;
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
                  fontSize: 16
                ),
              ),
            );
          }

          if (planet == null) {
            return const Center(child: Text("No Data Found", style: TextStyle(color: Colors.white)));
          }

          String massDisplay = "N/A";
          if (planet.planetMass != null && planet.planetMass!.isNotEmpty) {
            num mValue = planet.planetMass!['massValue'] as num;
            massDisplay = "${mValue.toStringAsFixed(2)} x 10^${planet.planetMass!['massExponent']} kg";
          }

          String volumeDisplay = "N/A";
          if (planet.planetVolume != null && planet.planetVolume!.isNotEmpty) {
            num vValue = planet.planetVolume!['volValue'] as num;
            volumeDisplay = "${vValue.toStringAsFixed(2)} x 10^${planet.planetVolume!['volExponent']} km³";
          }

          String discoveredBy = (
            planet.planetDiscoveryBy.trim().isEmpty ||planet.planetDiscoveryBy == "N/A"
          ) ? "Antiquity"  : planet.planetDiscoveryBy;  // Antiquity means Unknown from old times

          String discoveryDate = (
            planet.planetDiscoveryDate.trim().isEmpty || planet.planetDiscoveryDate == "N/A"
          ) ? "Unknown" : planet.planetDiscoveryDate;

          String tempInCelcius = "N/A";
          if (planet.averageTemp != 0) {
            tempInCelcius = "${(planet.averageTemp - 273.15).round()} °C";
          }

          String dayDisplay = "${planet.sideralRotation.round()} Hours";
          String yearDisplay = "${planet.sideralOrbit.round()} Earth Days";

          final List<Map<String, String>> planetDataList = [
            {"title" : "AvgTemp", "value" : tempInCelcius},
            {"title" : "Length of Day", "value" : dayDisplay},
            {"title" : "Length of Year", "value" : yearDisplay},
            {"title": "Gravity", "value": "${planet.planetGravity.toStringAsFixed(2)} m/s²"},
            {"title" : "mass", "value" : massDisplay},
            {"title" : "volume", "value" : volumeDisplay},
            {"title": "Known Moons", "value": "${planet.planetMoons.length}"},
            {"title": "Discovered By", "value": discoveredBy},
            {"title": "Discovery Date", "value": discoveryDate},
          ];
          
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 400.0,
                pinned: true, 
                backgroundColor: ColorPalettes.mainBackground, 
                elevation: 0,
                scrolledUnderElevation: 0,
                iconTheme: const IconThemeData(color: ColorPalettes.primaryWhite),
                centerTitle: true, 
          
                title: Text(
                  planet.planetName,
                  style: TextStyle(
                    color: ColorPalettes.primaryWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        "assets/images/${planet.planetName} Surface.png",
                        fit: BoxFit.cover,
                      ),
          
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent, 
                              ColorPalettes.mainBackground.withValues(alpha: 0.5,),
                              ColorPalettes.mainBackground, 
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      GridView.builder(
                        itemCount: planetDataList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.2
                        ),
                        itemBuilder: (context, index) {
                          final planetData = planetDataList[index];
                          return Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: ColorPalettes.cardBackground,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: ColorPalettes.subTextGray.withValues(alpha: 0.1), width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  planetData["title"]!,
                                  style: const TextStyle(
                                    color: ColorPalettes.subTextGray,
                                    fontSize: 14
                                  ),
                                ),

                                const SizedBox(height: 5,),

                                Text(
                                  planetData["value"]!,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: ColorPalettes.primaryWhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),          
            ],
          );
        }
      ),
    );
  }
}