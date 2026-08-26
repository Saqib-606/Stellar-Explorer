import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stellar_explorer/provider/iss_location_provider.dart';
import 'package:stellar_explorer/provider/iss_provider.dart';
import 'package:stellar_explorer/utils/color_palettes.dart';

class IssTrackerScreen extends StatefulWidget {
  const IssTrackerScreen({super.key});

  @override
  State<IssTrackerScreen> createState() => _ISSTrackerScreenState();
}

class _ISSTrackerScreenState extends State<IssTrackerScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final issProvider = context.read<IssProvider>();
      final locationProvider = context.read<IssLocationProvider>();

      await issProvider.getISSTrackerData();

      if (issProvider.issTracker != null) {
        locationProvider.fetchISSLocation(
          issProvider.issTracker!.latitude,
          issProvider.issTracker!.longitude,
        );
      }
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
          "ISS Tracker",
          style: TextStyle(
            color: ColorPalettes.primaryWhite,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer2<IssProvider, IssLocationProvider>(
        builder: (context, issprovider, isslocationprovider, child) {
          if (issprovider.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorPalettes.primaryWhite,
              ),
            );
          }

          if (issprovider.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                issprovider.errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            );
          }

          final issData = issprovider.issTracker;

          String formatTimestamp(int? timestamp) {
            if (timestamp == null || timestamp == 0) return "N/A";
            final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
            final hour = dateTime.hour > 12 ? dateTime.hour - 12 : (dateTime.hour == 0 ? 12 : dateTime.hour);
            final amPm = dateTime.hour >= 12 ? "PM" : "AM";
            final minute = dateTime.minute.toString().padLeft(2, '0');            
            final second = dateTime.second.toString().padLeft(2, '0',);
            return "$hour:$minute:$second $amPm";
          }

          String formatLatitude(double? lat) {
            if (lat == null) return "N/A";
            if (lat < 0) {
              return "${lat.abs().toStringAsFixed(2)}° S"; 
            } else {
              return "${lat.toStringAsFixed(2)}° N"; 
            }
          }

          String formatLongitude(double? lon) {
            if (lon == null) return "N/A";
            if (lon < 0) {
              return "${lon.abs().toStringAsFixed(2)}° W"; 
            } else {
              return "${lon.toStringAsFixed(2)}° E"; 
            }
          }

          final List<Map<String, dynamic>> issDataList = [
            {"title" : "Latitude", "value" : formatLatitude(issData?.latitude)},
            {"title" : "Longitude", "value" : formatLongitude(issData?.longitude)},
            {"title" : "Altitude", "value" : "${issData?.altitude.toStringAsFixed(2)} km"},
            {"title" : "Velocity", "value" : "${issData?.velocity.round()} km/h"},
            {"title" : "Visibility", "value" : "${issData?.visibility}"},
            {"title" : "Updated At", "value" : formatTimestamp(issData?.timeStamp)},
          ]; 

          String locationText = "Detecting...";
          if (!isslocationprovider.loading && isslocationprovider.issLocation != null) {
            final loc = isslocationprovider.issLocation!;
            locationText = loc.country.isEmpty ? loc.locality : "${loc.locality}, ${loc.country}";
          } else if (isslocationprovider.errorMessage.isNotEmpty) {
            locationText = "Location Unavailable";
          }

          return SingleChildScrollView(
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
                          "assets/images/ISS Tracker Image Original.png",
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
                    itemCount: issDataList.length,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.5
                    ),
                    itemBuilder: (context, index) {
                      final iss = issDataList[index];
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
                                iss["title"],
                                style: const TextStyle(
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
                                style: const TextStyle(
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
                        Expanded(
                          child: Padding(
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
                                  locationText,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                    
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          child: Opacity(
                            opacity: 0.6,
                            child: Container(
                              padding: const EdgeInsets.only(right: 15),
                              child: const Icon(
                                Icons.public,
                                color: ColorPalettes.primaryWhite,
                                size: 60,
                              ),
                            ), 
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
      )
    );
  }
}