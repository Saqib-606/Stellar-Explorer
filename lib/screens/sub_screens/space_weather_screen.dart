import 'package:flutter/material.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class SpaceWeatherScreen extends StatefulWidget {
  const SpaceWeatherScreen({super.key});

  @override
  State<SpaceWeatherScreen> createState() => _SpaceWeatherScreenState();
}

class _SpaceWeatherScreenState extends State<SpaceWeatherScreen> {
  final List<Map<String, dynamic>> solarMetrics = const [
    {
      "icon": Icons.air_rounded, // Solar wind
      "title": "Solar Wind",
      "value": "523",
      "unit": "km/s",
      "color": Colors.blueAccent,
    },
    {
      "icon": Icons.public_rounded, // Kp-Index
      "title": "Kp-Index",
      "value": "4",
      "unit": "Active",
      "color": Colors.orangeAccent,
    },
    {
      "icon": Icons.local_fire_department_rounded, // Solar Flares
      "title": "Solar Flares",
      "value": "M-Class",
      "unit": "High",
      "color": Colors.redAccent,
    },
    {
      "icon": Icons.speed_rounded, // CME Speed
      "title": "CME Speed",
      "value": "1200",
      "unit": "km/s",
      "color": Colors.purpleAccent,
    },
  ];

  final List<Map<String, dynamic>> weatherData = const [
    {
      "title": "Solar Flares",
      "subtitle": "Recent Class: C-class (Last 24h)",
      "detail": "Detailed beam observation about continuous events at...",
      "graphColor": Colors.yellowAccent,
    },
    {
      "title": "Geomagnetic Storms",
      "subtitle": "Kp-index: 4 (Unsettled)",
      "detail": "Detailed heliospheric observations and existences.",
      "graphColor": Colors.orangeAccent,
    },
    {
      "title": "Coronal Mass Ejections (CME)",
      "subtitle": "Arrival Forecast: Not Expected",
      "detail": "Arrival forecast is not expected to continue in the 24...",
      "graphColor": Colors.greenAccent,
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
                              "Solar activity is high.",
                              style: TextStyle(
                                color: ColorPalettes.primaryWhite,
                              ),
                            ),

                            const SizedBox(height: 5,),

                            const Text(
                              "Stay tuned for updates.",
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

              const SizedBox(height: 15),

              const Text(
                "Live Metrics",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorPalettes.primaryWhite,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 10),

              GridView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.6
                ),
                itemBuilder: (context, index) {
                  final metric = solarMetrics[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: ColorPalettes.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorPalettes.subTextGray.withValues(alpha: 0.15), width: 1)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: metric["color"].withValues(alpha: 0.15),
                              shape: BoxShape.circle
                            ),
                            child: Icon(
                              metric["icon"],
                              color: metric["color"],
                              size: 24,
                            ),
                          ),

                          const SizedBox(height: 8,),

                          Text(
                            metric["title"],
                            style: TextStyle(
                              color: ColorPalettes.subTextGray,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),          

                          const SizedBox(height: 5,),

                          Text(
                            metric["value"],
                            style: TextStyle(
                              color: ColorPalettes.primaryWhite,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5,),

                          Text(
                            metric["unit"],
                            style: TextStyle(
                              color: metric["color"],
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 15,),

              const Text(
                "Weather Overview",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorPalettes.primaryWhite,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 10,),

              ListView.builder(
                itemCount: weatherData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final weather = weatherData[index];
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
                                  weather["title"],
                                  style: const TextStyle(
                                    color: ColorPalettes.primaryWhite,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                const SizedBox(height: 4,),

                                Text(
                                  weather["subtitle"],
                                  style: const TextStyle(
                                    color: ColorPalettes.primaryWhite,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 4,),

                                Text(
                                  weather["detail"],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: ColorPalettes.subTextGray,
                                    fontSize: 11,
                                    height: 1.3
                                  ),
                                ),                              
                              ],
                            ),
                          ),
                          
                          const SizedBox(width: 15),

                          // Dummy Graph Placeholder (To be replaced with actual graph later)
                          Icon(
                            Icons.show_chart_rounded,
                            color: weather["graphColor"],
                            size: 35,
                          ),

                          const SizedBox(width: 15),
                          
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: ColorPalettes.subTextGray,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}