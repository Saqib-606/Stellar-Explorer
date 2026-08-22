import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stellar_explorer/provider/exoplanets_provider.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class ExoplanetsScreen extends StatefulWidget {
  const ExoplanetsScreen({super.key});

  @override
  State<ExoplanetsScreen> createState() => _ExoplanetsScreenState();
}

class _ExoplanetsScreenState extends State<ExoplanetsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExoplanetsProvider>().fetchExoPlanetsData();
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

              const SizedBox(height: 20,),
        
              Consumer<ExoplanetsProvider>(
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

                  if (provider.exoPlanets.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Exoplanets data avaliable",
                        style: TextStyle(color: ColorPalettes.primaryWhite),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: provider.exoPlanets.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final exoPlanet = provider.exoPlanets[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: ColorPalettes.cardBackground,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: ColorPalettes.subTextGray.withValues(alpha: 0.1,),width: 1,),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.public,
                                            color: Colors.blueAccent,
                                            size: 24,
                                          ),

                                          const SizedBox(width: 10),

                                          Expanded(
                                            child: Text(
                                              exoPlanet.planetName,
                                              style: const TextStyle(
                                                color:ColorPalettes.primaryWhite,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4,),
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent.withValues(alpha: 0.15,),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.3,),),
                                      ),
                                      child: Text(
                                        "Year: ${exoPlanet.discoveryYear}",
                                        style: const TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 15),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.wb_twilight_rounded,
                                            color: ColorPalettes.subTextGray,
                                            size: 16,
                                          ),

                                          const SizedBox(width: 6),

                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Host Star",
                                                  style: TextStyle(
                                                    color: ColorPalettes.subTextGray,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                                
                                                Text(
                                                  exoPlanet.hostName,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: ColorPalettes.primaryWhite,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.biotech_rounded,
                                            color: ColorPalettes.subTextGray,
                                            size: 16,
                                          ),

                                          const SizedBox(width: 6),

                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Method",
                                                  style: TextStyle(
                                                    color: ColorPalettes.subTextGray,
                                                    fontSize: 11,
                                                  ),
                                                ),

                                                Text(
                                                  exoPlanet.discoveryMethod,
                                                  style: const TextStyle(
                                                    color: ColorPalettes.primaryWhite,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow:TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 15),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10,),
                                        decoration: BoxDecoration(
                                          color: ColorPalettes.mainBackground.withValues(alpha: 0.5),
                                          borderRadius: BorderRadius.circular(10,),
                                          border: Border.all(color: Colors.purpleAccent.withValues(alpha: 0.2),),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Mass (Earths)",
                                              style: TextStyle(
                                                color: Colors.purpleAccent,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            const SizedBox(height: 2),

                                            Text(
                                              exoPlanet.planetMass,
                                              style: const TextStyle(
                                                color:ColorPalettes.primaryWhite,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 10),

                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10,),
                                        decoration: BoxDecoration(
                                          color: ColorPalettes.mainBackground.withValues(alpha: 0.5),
                                          borderRadius: BorderRadius.circular(10,),
                                          border: Border.all(color: Colors.tealAccent.withValues(alpha: 0.2,),),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Radius (Earths)",
                                              style: TextStyle(
                                                color: Colors.tealAccent,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            const SizedBox(height: 2),

                                            Text(
                                              exoPlanet.planetRadius,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color:ColorPalettes.primaryWhite,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
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