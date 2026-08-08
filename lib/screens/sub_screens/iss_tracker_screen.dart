import 'package:flutter/material.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class IssTrackerScreen extends StatefulWidget {
  const IssTrackerScreen({super.key});

  @override
  State <IssTrackerScreen> createState () => _ISSTrackerScreenState();
}

class _ISSTrackerScreenState extends State <IssTrackerScreen> {
  final List<Map<String, dynamic>> issData = const [
    {"label": "Latitude", "value": "51.5867°"},
    {"label": "Longitude", "value": "-0.1760°"},
    {"label": "Altitudue", "value": "408.5 km"},
    {"label": "Velocity", "value": "27,690 km/h"},
    {"label": "Status", "value": "Daylight"},
    {"label": "Upadted", "value": "10:31 AM"},
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
          "ISS Tracker",
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
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.44,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/ISS Earth.png",
                    ),
                    fit: BoxFit.cover
                  )
                ),
              ),
                
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.greenAccent, width: 1)
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, color: Colors.greenAccent, size: 10,),
                
                    SizedBox(width: 3,),
                
                    Text("LIVE",style: TextStyle(color: Colors.greenAccent,fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
                
              const SizedBox(height: 15,),
                
              GridView.builder(
                itemCount: issData.length,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5
                ),
                itemBuilder: (context, index) {
                  final iss = issData[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorPalettes.cardBackground
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: Text(
                            iss["label"],
                            style: TextStyle(
                              color: ColorPalettes.subTextGray,
                              fontSize: 11
                            ),
                          ),
                        ),
                
                        const SizedBox(height: 3,),
                
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            iss["value"],
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorPalettes.primaryWhite
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
                
              const SizedBox(height: 15,),
                
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.13,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Current Position",
                            style: TextStyle(color: ColorPalettes.primaryWhite, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                
                          const Text(
                            "The ISS is currently over",
                            style: TextStyle(color: ColorPalettes.primaryWhite),
                          ),
                
                          const SizedBox(height: 5),
                
                          Text(
                            "Indian Ocean",
                            style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                
                    const Spacer(), 
                
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      child: Opacity(
                        opacity: 0.6,
                        child: Icon(
                          Icons.public,
                          color: ColorPalettes.primaryWhite,
                          size: 60,
                        ), 
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}